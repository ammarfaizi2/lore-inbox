Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286590AbSAaKKw>; Thu, 31 Jan 2002 05:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285417AbSAaKKm>; Thu, 31 Jan 2002 05:10:42 -0500
Received: from mailgate.rz.uni-karlsruhe.de ([129.13.64.97]:16658 "EHLO
	mailgate.rz.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id <S286365AbSAaKKd>; Thu, 31 Jan 2002 05:10:33 -0500
Date: Thu, 31 Jan 2002 11:10:28 +0100 (CET)
From: Martin Bahlinger <ry42@rz.uni-karlsruhe.de>
X-X-Sender: <ry42@hek411.hek.uni-karlsruhe.de>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Current Reiserfs Update / 2.5.2-dj7 Oops
Message-ID: <Pine.LNX.4.31.0201311109510.660-100000@hek411.hek.uni-karlsruhe.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Oleg Drokin wrote:
> Ok, as of now, I tried vanilla 2.5.3 and it works.
> 2.5.2-dj7 breaks instantly on the first truncate call to reiserfs.
> I tried to dig up the difference between these 2 kernels but have not
> found anything that will change that behaviour yet. And resierfs code is
> identical.
> But dj7 seems to have a lot of modifications in the mm/* and fs/* stuff
> compared to 2.5.3

I have exactly the same problems you mentioned earlier in this thread. I
get the Ooops at various steps in the boot process. Sometimes the system
hangs directly after depmod, sometimes it can calculate the dependencies
and freezes when loading the first module (here: vfat.o)

This happens with 2.5.3 on a system with an IDE harddisk and root fs on
reiserfs.

bye
  Martin

-- 
Martin Bahlinger <bahlinger@rz.uni-karlsruhe.de>   (PGP-ID: 0x98C32AC5)

