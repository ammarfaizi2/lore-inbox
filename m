Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276618AbRJBTEM>; Tue, 2 Oct 2001 15:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276623AbRJBTED>; Tue, 2 Oct 2001 15:04:03 -0400
Received: from vela.salleURL.edu ([130.206.42.85]:52149 "EHLO
	vela.salleURL.edu") by vger.kernel.org with ESMTP
	id <S276618AbRJBTDu>; Tue, 2 Oct 2001 15:03:50 -0400
Date: Tue, 2 Oct 2001 21:22:20 +0200 (CEST)
From: Carles Pina i Estany <is08139@salleURL.edu>
To: <linux-kernel@vger.kernel.org>
Subject: System reset on Kernel 2.4.10
Message-ID: <Pine.LNX.4.33.0110022110070.21544-100000@vela.salleURL.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I have compiled Kernel 2.4.10 in a Debian Woody/Sid with a Pentium 2 450.

The Kernel works fine. But for error I execute /usr/src/linux/vmlinux as
root user. Then the system is rebooted (without unmounting anything)

Curious.

Then I execute vmlinux as normal user, and the system is rebooted!!!

If I execute this file in Kernel 2.4.6, then tell me "Segmentation
fault"

I copy this file to my laptop computer with Kernel 2.4.10 (Pentium 166
MMX) and execute as user. And reboot the system!

With a 2.4.9 Kernel, tell me "Segmentation fault".

A friend with Pentium 3, too reboot his system.

My /proc/cpuinfo of computer laptop:

carles@pinux:~$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 4
model name      : Pentium MMX
stepping        : 4
cpu MHz         : 167.047
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 mmx
bogomips        : 333.41

I do:

dd if=vmlinux of=hang bs=1k count=10

and this "mini-file" too reboot the system.

You can get this file here:
	http://www.salleurl.edu/~is08139/hang.html
(10 k)

I think that it is some bad instruction for CPU. But I think that Kernel
would control no? and a bad instruction in Pentium MMX (laptop), Pentium
3, and Pentium 2?

Thank you very much, and excuse me my bad English.

If you need more information about systems, configuration, etc. tell me.

----
Carles Pina i Estany | Nick: Pinux / Pine / Teufeus
http://www.salleURL.edu/~is08139/

   Tienes menos vocabulario que el diccionario de tarzán


