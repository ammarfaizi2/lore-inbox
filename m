Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281703AbRKQEbW>; Fri, 16 Nov 2001 23:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281702AbRKQEbM>; Fri, 16 Nov 2001 23:31:12 -0500
Received: from mailin8.bigpond.com ([139.134.6.96]:2789 "EHLO
	mailin8.bigpond.com") by vger.kernel.org with ESMTP
	id <S281701AbRKQEa4>; Fri, 16 Nov 2001 23:30:56 -0500
Content-Type: text/plain; charset=US-ASCII
From: hari <harisri@bigpond.com>
To: linux-kernel@vger.kernel.org
Subject: Linux-2.4.15-pre5 - PAM unable to dlopen(/lib/security/pam_pwcheck.so)
Date: Sat, 17 Nov 2001 15:33:56 +0000
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011117043102Z281701-17408+15303@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The following message (PAM related) appears while booting Linux-2.4.15-pre5 
and interrupts the booting process:

Nov 17 13:59:40 (none) kernel: Adding Swap: 265064k swap-space (priority 0)
Nov 17 13:59:40 (none) kernel: Adding Swap: 265064k swap-space (priority 0)
Nov 17 13:59:48 (none) login: PAM unable to 
dlopen(/lib/security/pam_pwcheck.so)
Nov 17 13:59:48 (none) login: PAM [dlerror: shared object not open]
Nov 17 13:59:48 (none) login: PAM adding faulty module: 
/lib/security/pam_pwchec
Nov 17 14:00:17 (none) kernel: reiserfs: checking transaction log (device 
09:00)
Nov 17 14:00:17 (none) kernel: Using r5 hash to sort names
Nov 17 14:00:17 (none) kernel: ReiserFS version 3.6.25

This does not happen with Linux-2.4.14, Linux-2.4.15-pre1, pre2, pre3 (I am 
unable to compile pre4 as the build process fails).

This is a reiserfs root file system, but I have the same problem with ext2 - 
root file system as well.

Hardware configuration:
MSI - 6341 Board
AMD Athlon 1.2 GHz
512 MB RAM
2 * 10 GB IDE Hard drives

Software configuration:
Linux pengu 2.4.14 #1 Tue Nov 6 18:34:31 GMT 2001 i686 unknown

Gnu C                  2.95.2
Gnu make               3.79.1
binutils               2.10.0.33
util-linux             2.11b
mount                  2.11b
modutils               2.4.1
e2fsprogs              1.22
PPP                    2.4.0
isdn4k-utils           3.1pre1a
Linux C Library        x    1 root     root      1382179 Jan 19  2001 
/lib/libc.so.6
Dynamic linker (ldd)   2.2
Procps                 2.0.7
Net-tools              1.57
Kbd                    1.02
Sh-utils               2.0
Modules Loaded         emu10k1 ac97_codec soundcore ext2

Please ask me if you need more information, such as .config file etc. Please 
CC me if you can, else I will refer the lkml archive at marc.theaimsgroup.com.

Thanks in advance.
-- 
Hari.
harisri@bigpond.com

