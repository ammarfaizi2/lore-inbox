Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272464AbRIMWAw>; Thu, 13 Sep 2001 18:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272531AbRIMWAm>; Thu, 13 Sep 2001 18:00:42 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11527 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272464AbRIMWA1>; Thu, 13 Sep 2001 18:00:27 -0400
Subject: Re: How errorproof is ext2 fs?
To: otto.wyss@bluewin.ch
Date: Thu, 13 Sep 2001 23:05:13 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BA1258F.5CC18A2C@bluewin.ch> from "Otto Wyss" at Sep 13, 2001 11:30:56 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15hebh-0007QK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> due to an not responding USB-keyboard/-mouse (what a nice coincident). Now while
> the Mac restarted without any fuse I had to fix the ext2-fs manually for about
> 15 min. Luckily it seems I haven't lost anything on both system. 
> 
> This leaves me a bad taste of Linux in my mouth. Does ext2 fs really behave so
> worse in case of a crash? Okay Linux does not crash that often as MacOS does, so

That sounds like it behaved well. fsck didnt have enough info to safely
do all the fixup without asking you. Its not a reliability issue as such.

> it does not need a good  error proof fs. Still can't ext2 be made a little more
> error proof?

Ext3 is a journalled ext2. Its in the 2.4-ac kernel trees. Reiserfs in the
-ac tree also supports big endian boxes.

Alan
