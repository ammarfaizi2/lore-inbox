Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131451AbRAFMde>; Sat, 6 Jan 2001 07:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131452AbRAFMdY>; Sat, 6 Jan 2001 07:33:24 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:31985 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S131451AbRAFMdJ>; Sat, 6 Jan 2001 07:33:09 -0500
Date: Sat, 6 Jan 2001 13:33:16 +0100 (CET)
From: Matthias Juchem <matthias@gandalf.math.uni-mannheim.de>
Reply-To: Matthias Juchem <juchem@uni-mannheim.de>
To: "Jeremy M. Dolan" <jmd@foozle.turbogeek.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Bug reporting script? (was: removal of redundant line in
 documentation)
In-Reply-To: <20010106075402.A3377@foozle.turbogeek.org>
Message-ID: <Pine.LNX.4.30.0101061327090.4099-100000@gandalf.math.uni-mannheim.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Jan 2001, Jeremy M. Dolan wrote:

> If ver_linux can take off one of those steps, why not include a script
> which takes care of ALL the leg work? All of the files it asks the
> reporter to include are o+r...

If have started a script that produces the following output. ( some fields
need to be filled, but the structure will be like that). If you have additional
ideas, please tell me. I'll include some more version numbers from system tools
and, maybe, a routine that calls ksymoops.

Regards,
 Matthias

Linux Kernel Problem Report
===============================================================================
1. One line summary of the problem
----------------------------------------------
Error in module foo

2. Full description of the problem
----------------------------------------------
some text
.
.


3. Keywords
----------------------------------------------
modules, foo

4. Kernel version
----------------------------------------------
Linux version 2.4.0 (root@gandalf) (gcc version 2.95.2 19991024 (release)) #6 Sat Jan 6 03:37:57 CET 2001

5. Oops message with symbolic info
----------------------------------------------

6. Example that triggers the problem
----------------------------------------------

7. System information
----------------------------------------------
a) software
 GNU C                 2.95.2
 Modutils              2.4.0
 GNU make              3.79.1
 Binutils              2.9.5.0.24
 Linux C library       2.1.3
 Dynamic linker/loader 2.1.3
 Linux C++ library     2.7.2
 Procps                2.0.6
 Net-tools             1.56
 Kdb                   0.99
 Sh-utils              2.0
 Util-linux            2.10r
 E2fsprogs             1.19

b) loaded modules
aic7xxx scsi_mod ipv6 ne2k-pci 8390 serial isa-pnp unix

c) /proc/cpuinfo
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 5
model		: 7
model name	: AMD-K6tm w/ multimedia extensions
stepping	: 0
cpu MHz		: 300.689
cache size	: 64 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8 mmx
bogomips	: 599.65


d) /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0213-0213 : isapnp read
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
5f00-5f1f : Intel Corporation 82371AB PIIX4 ACPI
6100-613f : Intel Corporation 82371AB PIIX4 ACPI
6400-64ff : Adaptec AIC-7881U
  6400-64fe : aic7xxx
6800-681f : Intel Corporation 82371AB PIIX4 USB
6900-691f : Realtek Semiconductor Co., Ltd. RTL-8029(AS)
  6900-691f : ne2k-pci
f000-f00f : Intel Corporation 82371AB PIIX4 IDE

e) /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000cc7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-03ffffff : System RAM
  00100000-001a130f : Kernel code
  001a1310-001d948f : Kernel data
e0000000-e07fffff : S3 Inc. 86c764/765 [Trio32/64/64V+]
e0800000-e0800fff : Adaptec AIC-7881U
ffff0000-ffffffff : reserved

f) PCI information

g) SCSI information

h) further information (from /proc and other)

8. Other notes, patches, fixes, workarounds...
----------------------------------------------



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
