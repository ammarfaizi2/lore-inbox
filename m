Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317271AbSFLAWb>; Tue, 11 Jun 2002 20:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317277AbSFLAWa>; Tue, 11 Jun 2002 20:22:30 -0400
Received: from 04-195.088.popsite.net ([64.24.84.195]:11392 "EHLO perl")
	by vger.kernel.org with ESMTP id <S317271AbSFLAWa>;
	Tue, 11 Jun 2002 20:22:30 -0400
Date: Wed, 12 Jun 2002 00:22:29 +0000
To: linux-kernel@vger.kernel.org
Cc: xsdg@mangalore.zipworld.com.au
Subject: computer reboots before "Uncompressing Linux..." with 2.5.19-xfs
Message-ID: <20020612002229.A27386@216.254.117.126>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
From: xsdg <xsdg@openprojects.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hola...
I'm trying to get kernel 2.5.19-xfs working on one of my boxes...  The box is
a P200-MMX, currently running 2.5.7-xfs and using grub as the bootloader.  Each
time I try to boot the kernel, grub tells me...

root (hd0,0)
 Filesystem type is ext2fs, partition type 0x83
kernel /boot/kernels/19.5.2k-xfs single
 [Linux-bzImage, setup=0x1400, size=0x134aff]

Then, after a small pause, the box reboots (note: it does _not_ print
"Uncompressing Linux...").  I have tried the following:
1) Compile the kernel, optimized for P-MMX, on another box (PII-350 Deschutes)
   using gcc 2.95.4
2) Recompile bzImage
3) Recompile bzImage
4) Remove framebuffer support.  Remove vid mode selection support.  Optimize
   for Pentium-Classic.  Recompile with everything else the same
5) Recompile on target box (gcc 2.95.4 also) with options the same as after #4

All of my boxes are running Debian SID (not necessarily up-to-date).  I asked a
number of times in #kernelnewbies on OPN, to no avail.  Any and all
help would be greatly appreciated. (Please CC me in replies)

	--xsdg
-- 
|---------------------------------------------------|
| It's not the fall that kills you, it's the        |
|   landing.                                        |
|---------------------------------------------------|
| http://xsdg.hypermart.net   xsdg@openprojects.net |
|---------------------------------------------------|
