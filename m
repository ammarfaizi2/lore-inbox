Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266686AbUBGIyr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 03:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266687AbUBGIyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 03:54:47 -0500
Received: from www.isical.ac.in ([202.54.54.145]:33699 "EHLO isical.ac.in")
	by vger.kernel.org with ESMTP id S266686AbUBGIyo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 03:54:44 -0500
Date: Sat, 7 Feb 2004 14:13:33 +0530 (IST)
From: Subhasis Kumar Pal <subhasis@isical.ac.in>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM modules loading 
Message-ID: <Pine.LNX.4.44.0402071354060.764-100000@www.isical.ac.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sir,
    I am trying to load kernel-2.6.2 in my p-iv machine. I am giving the 
following information.

Machine : P-IV
OS : Redhat 9(kernel-2.4.20-28.9)

Command for compilation of kernel-2.6.2 after untar the file 
(linux-2.6.2.tar).

 1. make mrproper
 2. make xconfig
 3. make modules
 4. make modules_install
 5. make install

Error for the command "make install" :


    make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
Kernel: arch/i386/boot/bzImage is ready
sh /root/linux-2.6.2/arch/i386/boot/install.sh 2.6.2 
arch/i386/boot/bzImage System.map ""
No module aic7xxx found for kernel 2.6.2
mkinitrd failed
make[1]: *** [install] Error 1
make: *** [install] Error 2

   But the module file called aic7xxx.ko is present in the directory at
"/lib/module/2.6.2/kernel/drivers/scsi/aic7xxx"


  I have checked the upper version of the following software is at my 
machine. 

   o  Gnu C                  2.95.3                  # gcc --version
o  Gnu make               3.78                    # make --version
o  binutils               2.12                    # ld -v
o  util-linux             2.10o                   # fdformat --version
o  module-init-tools      0.9.10                  # depmod -V
o  e2fsprogs              1.29                    # tune2fs
o  jfsutils               1.1.3                   # fsck.jfs -V
o  reiserfsprogs          3.6.3                   # reiserfsck -V 
2>&1|grep reiserfsprogs
o  xfsprogs               2.6.0                   # xfs_db -V
o  pcmcia-cs              3.1.21                  # cardmgr -V
o  quota-tools            3.09                    # quota -V
o  PPP                    2.4.0                   # pppd --version
o  isdn4k-utils           3.1pre1                 # isdnctrl 2>&1|grep 
version
o  nfs-utils              1.0.5                   # showmount --version
o  procps                 3.1.13                  # ps --version
o  oprofile               0.5.3                   # oprofiled --version

    I think it is the problem for module extention (.ko). 

    Please send a suitable solution for the above as early as possible. 


Subhasis Pal
(System Administrator)
Indian Statistical Institute,
Kolkata, India.


