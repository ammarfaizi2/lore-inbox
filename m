Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263440AbTH3BtE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 21:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263478AbTH3BtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 21:49:04 -0400
Received: from 202-47-55-78.adsl.gil.com.au ([202.47.55.78]:13954 "HELO
	longlandclan.hopto.org") by vger.kernel.org with SMTP
	id S263440AbTH3Bs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 21:48:57 -0400
Message-ID: <3F500285.9080104@longlandclan.hopto.org>
Date: Sat, 30 Aug 2003 11:48:53 +1000
From: Stuart Longland <stuartl@longlandclan.hopto.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jamie@shareable.org
CC: linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
References: <20030829053510.GA12663@mail.jlokier.co.uk> <20030829154700.GB15693@DUK2.13thfloor.at>
In-Reply-To: <20030829154700.GB15693@DUK2.13thfloor.at>
X-Enigmail-Version: 0.75.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

	I've thrown this at a Gateway Microserver (aka. Sun Cobalt Qube) which
runs an r5k little endian MIPS.  I'd also throw this at a Silicon
Graphics Indy, but I don't feel energetic enough right now to go and
drag the beast out.

	Also attached, is the results from my laptop (Toshiba Protege 7010CT)
and web server (Generic Dual P-Pro).


- --
+-------------------------------------------------------------+
| Stuart Longland           stuartl at longlandclan.hopto.org |
| Brisbane Mesh Node: 719             http://stuartl.cjb.net/ |
| I haven't lost my mind - it's backed up on a tape somewhere |
| Griffith Student No:           Course: Bachelor/IT (Nathan) |
+-------------------------------------------------------------+


- -------------------< From the qube >-----------------------
Test separation: 4096 bytes: FAIL - cache not coherent
Test separation: 8192 bytes: FAIL - cache not coherent
Test separation: 16384 bytes: pass
Test separation: 32768 bytes: pass
Test separation: 65536 bytes: pass
Test separation: 131072 bytes: pass
Test separation: 262144 bytes: pass
Test separation: 524288 bytes: pass
Test separation: 1048576 bytes: pass
Test separation: 2097152 bytes: pass
Test separation: 4194304 bytes: pass
Test separation: 8388608 bytes: pass
Test separation: 16777216 bytes: pass
VM page alias coherency test: minimum fast spacing: 16384 (4 pages)

real    0m0.276s
user    0m0.140s
sys     0m0.120s

system type		: MIPS Cobalt
processor		: 0
cpu model		: Nevada V10.0  FPU V10.0
BogoMIPS		: 249.85
wait instruction	: yes
microsecond timers	: yes
tlb_entries		: 48
extra interrupt vector	: yes
hardware watchpoint	: no
VCED exceptions		: not available
VCEI exceptions		: not available
- -------------------< From the qube >-----------------------

- ------------------< From the laptop >----------------------
Test separation: 4096 bytes: pass
Test separation: 8192 bytes: pass
Test separation: 16384 bytes: pass
Test separation: 32768 bytes: pass
Test separation: 65536 bytes: pass
Test separation: 131072 bytes: pass
Test separation: 262144 bytes: pass
Test separation: 524288 bytes: pass
Test separation: 1048576 bytes: pass
Test separation: 2097152 bytes: pass
Test separation: 4194304 bytes: pass
Test separation: 8388608 bytes: pass
Test separation: 16777216 bytes: pass
VM page alias coherency test: all sizes passed

real    0m0.195s
user    0m0.142s
sys     0m0.052s

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 5
model name	: Pentium II (Deschutes)
stepping	: 2
cpu MHz		: 300.026
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat
pse36 mmx fxsr
bogomips	: 591.87
- ------------------< From the laptop >----------------------

- ----------------< From the web server >--------------------
Test separation: 4096 bytes: pass
Test separation: 8192 bytes: pass
Test separation: 16384 bytes: pass
Test separation: 32768 bytes: pass
Test separation: 65536 bytes: pass
Test separation: 131072 bytes: pass
Test separation: 262144 bytes: pass
Test separation: 524288 bytes: pass
Test separation: 1048576 bytes: pass
Test separation: 2097152 bytes: pass
Test separation: 4194304 bytes: pass
Test separation: 8388608 bytes: pass
Test separation: 16777216 bytes: pass
VM page alias coherency test: all sizes passed

real    0m0.279s
user    0m0.210s
sys     0m0.060s

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 1
model name	: Pentium Pro
stepping	: 9
cpu MHz		: 199.434
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
bogomips	: 398.13

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 1
model name	: Pentium Pro
stepping	: 9
cpu MHz		: 199.434
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
bogomips	: 398.13
- ----------------< From the web server >--------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/UAKFIGJk7gLSDPcRAif8AJ9WKjTGIGYJdHgME/Fkac4cNZKUkACdHwA5
yHQlu/O96H4IUHKGflJncmI=
=yAoq
-----END PGP SIGNATURE-----

