Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284263AbRLMP0I>; Thu, 13 Dec 2001 10:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284258AbRLMPZ6>; Thu, 13 Dec 2001 10:25:58 -0500
Received: from uterpendragon.cnam.fr ([163.173.213.89]:35712 "EHLO
	Weierstrass.cnam.fr") by vger.kernel.org with ESMTP
	id <S284204AbRLMPZo>; Thu, 13 Dec 2001 10:25:44 -0500
Message-ID: <3C18C8A3.6080307@free.fr>
Date: Thu, 13 Dec 2001 16:26:27 +0100
From: BERTRAND =?ISO-8859-15?Q?Jo=EBl?= <joel.k.bertrand@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: fr-fr, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Sparc32 and last stable kernel
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

	I have two SS5, one as a "pizza box" and a laptop. I have compiled the 
2.4.16 and 17pre8 kernels on the both.

	On the first station, I have :

bertrand@morgane:/boot$ ls -l vmlinuz-2.4.16
-rwxr-xr-x    1 root     root      2134444 Nov 30 10:47 vmlinuz-2.4.16
bertrand@morgane:/boot$ cat /proc/cpuinfo
cpu             : Fujitsu  MB86904
fpu             : Lsi Logic/Meiko L64804 or compatible
promlib         : Version 3 Revision 2
prom            : 2.15
type            : sun4m
ncpus probed    : 1
ncpus active    : 1
BogoMips        : 109.36
MMU type        : Fujitsu Swift
contexts        : 256
nocache total   : 1048576
nocache used    : 95744
bertrand@morgane:/boot$ silo -V
SILO version 1.2.4

	and on the second :

Root Kepler:[/boot] > ls -l vmlinuz-2.4.17pre8
-rwxr-xr-x    1 root     root      1079077 Dec 13 15:11 vmlinuz-2.4.17pre8
Root Kepler:[/boot] > cat /proc/cpuinfo
cpu             : Fujitsu  MB86904
fpu             : Lsi Logic/Meiko L64804 or compatible
promlib         : Version 3 Revision 2
prom            : 2.15
type            : sun4m
ncpus probed    : 1
ncpus active    : 1
BogoMips        : 84.78
MMU type        : Fujitsu Swift
invall          : 0
invmm           : 0
invrnge         : 0
invpg           : 0
contexts        : 256
Root Kepler:[/boot] > silo -V
SILO version 1.2.4

	The kernel on the second station seems to be smaller than the first 
kernel used on the first station. The bootprom are the same, but when I 
try to boot, silo returns on the secon station that the kernel is too 
big. I don't understand where is the trouble.

	I have tried a uncompressed kernel, but the result is the same.

	Thanks in advance,

	JKB

