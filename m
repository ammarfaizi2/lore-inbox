Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131439AbQKZXsW>; Sun, 26 Nov 2000 18:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131930AbQKZXsN>; Sun, 26 Nov 2000 18:48:13 -0500
Received: from [212.6.212.55] ([212.6.212.55]:10509 "EHLO
        wunderserver6.tmag.de") by vger.kernel.org with ESMTP
        id <S131439AbQKZXsC> convert rfc822-to-8bit; Sun, 26 Nov 2000 18:48:02 -0500
From: Stefan Frings <stefan@edv-frings.de>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: cannot ls cdroms (_isofs_bmap block >= EOF)
Date: Mon, 27 Nov 2000 00:16:41 +0100
X-Mailer: KMail [version 1.0.29.2]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <00112700180300.08780@notebook>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:  

cannot ls cdroms (_isofs_bmap block >= EOF)

[2.] Full description of the problem/report:

I cannot run ls on cdroms with kernel 2.4.0-test11. I get the 
message "_isofs_bmap block >= EOF". Kernel 2.0.4-test8 and test10 
work fine for me. I did not test other 2.4.0 versions. It makes no
difference if I compile isofs as "M" or "Y".

[3.] Keywords (i.e., modules, networking, kernel):

kernel, isofs, cdrom, bmap, mount, ls

[4.] Kernel version (from /proc/version):

2.4.0-test11

[6.] A small shell script or example program which triggers the
     problem (if possible)
     
mount /dev/hdc1 /mnt
dir /mnt
     
[7.1.] Software (add the output of the ver_linux script here)

Kernel modules		2.3.21
Gnu C			2.95.2
Gnu Make		3.79.1
Binutils		2.9.5.0.24
Dynamic Linker		ldd (GNU libc) 2.1.13
Procps			2.0.6
Mount			2.10q
Net-tools		1.56
Kbd			0.99
Sh-utils		2.0
Modules loaded		no modules loaded

[7.2.] Processor information (from /proc/cpuinfo):

AMD K6-2 366

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

Intel 82371AB PIIX 4 ACPI

[X.] Other notes, patches, fixes, workarounds:

I tried to use the isofs sources from version 2.4.0-test10 in 2.4.0-test11
they are not compatible. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
