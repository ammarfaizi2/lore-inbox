Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129414AbQKQTVP>; Fri, 17 Nov 2000 14:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129664AbQKQTVF>; Fri, 17 Nov 2000 14:21:05 -0500
Received: from ns1.poda.cz ([62.168.18.10]:7181 "EHLO ns1.poda.cz")
	by vger.kernel.org with ESMTP id <S129270AbQKQTU4>;
	Fri, 17 Nov 2000 14:20:56 -0500
Date: Fri, 17 Nov 2000 19:50:52 +0100 (CET)
From: David Trcka <trcka@poda.cz>
To: linux-kernel@vger.kernel.org
cc: David Trcka <trcka@poda.cz>
Subject: kernel: free_one_pmd: bad directory entry 00000800
Message-ID: <Pine.LNX.4.20.0011171938300.31512-100000@ns1.poda.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

one question:

Nov 17 02:43:19 ns1 kernel: free_one_pmd: bad directory entry 00000800

This appears in log about once a day, not periodically. What does it
exactly mean? More info follows:

ns1:~$ dmesg |head -1
Linux version 2.2.17 (root@ns1) (gcc version egcs-2.91.66 19990314/Linux
(egcs-1.1.2 release)) #2 SMP Mon Nov 13 06:18:22 CET 2000
ns1:~$ cat /proc/cpuinfo 
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 5
model name	: Pentium II (Deschutes)
stepping	: 1
cpu MHz		: 348.210
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
sep_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr
bogomips	: 696.32

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 5
model name	: Pentium II (Deschutes)
stepping	: 1
cpu MHz		: 348.210
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
sep_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr
bogomips	: 694.68
ns1:~$ cat /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
Mem:  529522688 525144064  4378624 146665472 32501760 105422848
Swap: 1085571072   335872 1085235200
MemTotal:    517112 kB
MemFree:       4276 kB
MemShared:   143228 kB
Buffers:      31740 kB
Cached:      102952 kB
SwapTotal:  1060128 kB
SwapFree:   1059800 kB



__________________________________________
    David Trcka, network administrator
  PODA s.r.o., Internet Service Provider
Ostrava, 28. rijna 150, The Czech Republic
        Voice/Fax: +420 69 6612600
        PGP KeyID: DAE55DA4


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6FX4P5z9w2trlXaQRAjxaAJ9SJjLOB0DKmJvzjsTZshXKah5hhgCeK8s6
kEkAHq6p+D7Owd83nRusoPM=
=JtOe
-----END PGP SIGNATURE-----

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
