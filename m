Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277826AbRJRRFm>; Thu, 18 Oct 2001 13:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277808AbRJRRFX>; Thu, 18 Oct 2001 13:05:23 -0400
Received: from linux06.unm.edu ([129.24.15.38]:22290 "HELO linux06.unm.edu")
	by vger.kernel.org with SMTP id <S277807AbRJRRFR>;
	Thu, 18 Oct 2001 13:05:17 -0400
Date: Thu, 18 Oct 2001 11:05:38 -0600 (MDT)
From: Todd <todd@unm.edu>
To: <linux-kernel@vger.kernel.org>
Subject: ia64 gcc compile prob
Message-ID: <Pine.A41.4.33.0110181103240.31982-100000@aix07.unm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

folx,

i've searched archives & the web and can't find reference to this:

i'm getting:

gcc -D__KERNEL__
-I/home/jotto/Cplant/top.10-17/compute/OS/linux-patches/linux-2.4.7/linux/include
-Wall -Wstrict-prototypes -Wno-trigraphs -g -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe  -ffixed-r13
-mfixed-range=f10-f15,f32-f127 -falign-functions=32 -DMODULE   -c -o
scsi_ioctl.o scsi_ioctl.c
scsi_ioctl.c: In function `scsi_ioctl_send_command':
scsi_ioctl.c:366: Internal compiler error in rws_access_regno, at
config/ia64/ia64.c:3689


when trying to compile scsi_ioctl.c on ia64 using

gcc -v
Reading specs from /usr/lib/gcc-lib/ia64-redhat-linux/2.96/specs
gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-81)

on 2.4.7 and 2.4.11 patched with the appropriate patches from ports/ia64.

are there known issues with gcc 2.96 on ia64 and if so, what are the
known slns?  thanks,

=========================================================
Todd Underwood, todd@unm.edu

=========================================================

