Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269413AbRINTQp>; Fri, 14 Sep 2001 15:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269326AbRINTQf>; Fri, 14 Sep 2001 15:16:35 -0400
Received: from relay01.cablecom.net ([62.2.33.101]:7951 "EHLO
	relay01.cablecom.net") by vger.kernel.org with ESMTP
	id <S268702AbRINTQc>; Fri, 14 Sep 2001 15:16:32 -0400
Message-ID: <3BA257A5.E74DDBAB@bluewin.ch>
Date: Fri, 14 Sep 2001 21:16:53 +0200
From: Otto Wyss <otto.wyss@bluewin.ch>
Reply-To: otto.wyss@bluewin.ch
X-Mailer: Mozilla 4.78 (Macintosh; U; PPC)
X-Accept-Language: de,en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: How errorproof is ext2 fs?
In-Reply-To: <E15hebh-0007QK-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This leaves me a bad taste of Linux in my mouth. Does ext2 fs really behave so
> > worse in case of a crash? Okay Linux does not crash that often as MacOS does, so
> 
> That sounds like it behaved well. fsck didnt have enough info to safely
> do all the fixup without asking you. Its not a reliability issue as such.
> 
Well it could also be the fact that almost no activity was going on on both
systems. 

> > it does not need a good  error proof fs. Still can't ext2 be made a little more
> > error proof?
> 
> Ext3 is a journalled ext2. Its in the 2.4-ac kernel trees. Reiserfs in the
> -ac tree also supports big endian boxes.
> 
At least ext2 and probably all the journalling fs lacks a feature the HFS+ from
the Mac has (bad tongues might say "needs"), to keep open files without activity
in a state where a crash has no effect. I don't know how it is done since I'm no
fs expert but my experience with my Mac (resetting about once a month without
loosing anything) shows that it's possible.

I'd rather like to see this feature appear in one fs for Linux (preferable
ext2). I think it's always better to not have error instead of fixing them afterwards.

O. Wyss
