Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284177AbRL1XK2>; Fri, 28 Dec 2001 18:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284285AbRL1XKT>; Fri, 28 Dec 2001 18:10:19 -0500
Received: from phosphor.cipic.ucdavis.edu ([169.237.153.5]:52999 "EHLO
	phosphor.cipic.ucdavis.edu") by vger.kernel.org with ESMTP
	id <S284177AbRL1XKI>; Fri, 28 Dec 2001 18:10:08 -0500
Message-Id: <4.3.1.2.20011228145143.00b8d7e0@phosphor.cipic.ucdavis.edu>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.1
Date: Fri, 28 Dec 2001 15:09:59 -0800
To: linux-kernel@vger.kernel.org
From: Dennis Thompson <yknot@cipic.ucdavis.edu>
Subject: 2.4.17 - HIMEM option creates unresolved symbols for FS modules
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a pentium 4 machine running RedHat 7.2 into which I just install 1GB of RAM.  I compiled the 2.4.17 kernel and modules with the 4GB memory option.  On rebooting the system with the new kernel several error messages where generated.  depmod -e reported unresolved symbols for many file system modules including but not limited to: nfs nfsd loop smbfs and reiserfs.

I re-complied the kernel with only one change, High Memory Support was turned off. The new kernel worked great and I had no unresolved symbols in any of the re-compiled modules.



Gnu C                  2.96
Gnu make               3.79.1
binutils               2.11.90.0.8
util-linux             2.11f
mount                  2.11g
modutils               2.4.6
e2fsprogs              1.23
reiserfsprogs          3.x.0j
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         sg sr_mod cdrom i810_audio ac97_codec soundcore radeon agpgart nfs autofs4 nfsd lockd sunrpc 3c59x ide-scsi scsi_mod reiserfs mousedev hid input usb-uhci usbcore rtc


