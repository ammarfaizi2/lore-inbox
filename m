Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287200AbRL2WwH>; Sat, 29 Dec 2001 17:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287202AbRL2Wvs>; Sat, 29 Dec 2001 17:51:48 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33028 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287200AbRL2Wvn>; Sat, 29 Dec 2001 17:51:43 -0500
Subject: Re: The direction linux is taking
To: lm@bitmover.com (Larry McVoy)
Date: Sat, 29 Dec 2001 22:58:27 +0000 (GMT)
Cc: bcrl@redhat.com (Benjamin LaHaise), oxymoron@waste.org (Oliver Xymoron),
        wingel@hog.ctrl-c.liu.se (Christer Weinigel),
        linux-kernel@vger.kernel.org
In-Reply-To: <20011229140410.A13883@work.bitmover.com> from "Larry McVoy" at Dec 29, 2001 02:04:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16KSQt-0005zf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Wrong.  Most patches are independant, and even touch different functions.  
> 
> Really?  And the data which shows this absolute statement to be true is
> where?  I'm happy to believe data, but there is no data here.

I rarely get clashes in merges with either 2.2 or with 2.4-ac when I was
doing it. Offsets from multiple patches to the same file happen some times
but its very rare two people had overlapping changes and when it happened
it almost always meant that the two of them needed to talk because they were
fixing the same thing or adding related features.
 
The big exception is Configure.help which is a nightmare for patch, and the
one file I basically always did hand merges on
