Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267695AbRG0PvI>; Fri, 27 Jul 2001 11:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268872AbRG0Pu6>; Fri, 27 Jul 2001 11:50:58 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:64520 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267695AbRG0Puv>; Fri, 27 Jul 2001 11:50:51 -0400
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
To: reiser@namesys.com (Hans Reiser)
Date: Fri, 27 Jul 2001 16:51:16 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        menion@srci.iwpsd.org (Joshua Schmidlkofer),
        linux-kernel@vger.kernel.org (kernel)
In-Reply-To: <no.id> from "Hans Reiser" at Jul 27, 2001 07:31:09 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Q9tU-0005vk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> > No. The only thing I can think of that might slow it is that we build with
> > the reiserfs paranoia/sanity checks on. Thats because at the time 7.1 was
> 
> Yes, that option should never be on for an end user not having a bug that he wants a more detailed
> bug report on.  It just makes us look slow compared to ext2.

Maybe its old fashioned but we'd rather any inconsistency in the file system
behaviour was made obvious to the end user. Enterprise customers object to
losing data.

> 2.4.2 was not a stable kernel for any FS, not just for ReiserFS.

The RH 2.4.2 derived kernel isnt 2.4.2 by any stretch of the imagination. 
Vanilla 2.4.2 wouldnt pass a test suite.

> I don't think that even with CONFIG_REISERFS_CHECK on, journal replay can take as long as fsck on
> ext2.  reiserfsck though, if that was on, oh, could even RedHat be that desperate to make us look
> bad to users as to run reiserfsck at every boot?

Hans, if you stopped considering every report that your file system wasn't
the best in the world as either a conspiracy theory or someone elses fault
you'd have a much better product

Nobody needs conspiracies to not use reiserfs as their core fs, and until
things like big endian support are cleanly resolved that isnt likely to
change.

Alan
