Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261327AbSJ1QBH>; Mon, 28 Oct 2002 11:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261330AbSJ1QBH>; Mon, 28 Oct 2002 11:01:07 -0500
Received: from hermes.univ-evry.fr ([194.199.90.32]:38564 "EHLO
	hermes.univ-evry.fr") by vger.kernel.org with ESMTP
	id <S261327AbSJ1QBC>; Mon, 28 Oct 2002 11:01:02 -0500
Date: Mon, 28 Oct 2002 17:00:29 +0100 (CET)
From: Daniel Goujot <Daniel.Goujot@maths.univ-evry.fr>
To: <linux-kernel@vger.kernel.org>
Subject: No rtl8139 found in menuconfig in linux-2.2.22
Message-ID: <Pine.LNX.4.33L2.0210281646450.14810-100000@grozny.maths.univ-evry.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] No rtl8139 found in menuconfig in linux-2.2.22
[2.] Full description of the problem/report:
download http://www.kernel.org/pub/linux/kernel/v2.2/linux-2.2.22.tar.gz
cd /usr/src
mkdir linux-2.2.22
ln -si linux-2.2.22 linux
tar zxf linux-2.2.22.tar.gz
cd /usr/src/linux
make mrproper
make menuconfig
-- don't find the rtl8139 (I found the tulip network driver, not the rtl8139 network driver)
make bzImage (it works, but without rtl8139)
[3.] menuconfig rtl8139 2.2.22
[4.] menuconfig problem
[5.] Output of Oops.. message : None
[6.] A small shell script or example program which triggers the
     problem (if possible) : see above
[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
Linux r22m73.cybercable.tm.fr 2.2.10 #1 Tue Jul 20 16:32:24 MEST 1999 i686 unknown
Kernel modules         [5]
Gnu C                  egcs-2.91.66
Binutils               2.9.1.0.25
Linux C Library        (manually, ldd --version) ldd (GNU libc) 2.1.1
/usr/lib/libg++-1.so.2
/usr/lib/libg++-2-libc6.1-1-2.8.1.3.a
/usr/lib/libg++-2-libc6.1-1-2.8.1.3.so
/usr/lib/libg++-libc6.1-1.a.2
/usr/lib/libg++-libc6.1-1.so.2
/usr/lib/libg++.so.2.7.2
Procps                 1.2.11
Mount                  2.9t
Net-tools              (1999-04-20)
Kbd                    0.99
Sh-utils               1.16
[7.2.] Processor information (from /proc/cpuinfo): no concern
[7.3.] Module information (from /proc/modules): no concern
[7.4.] SCSI information (from /proc/scsi/scsi): no concern
[7.5.] Other information that might be relevant to the problem: none
[X.] Other notes, patches, fixes, workarounds: no patch.





