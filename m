Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132575AbRDOD4D>; Sat, 14 Apr 2001 23:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132574AbRDODzx>; Sat, 14 Apr 2001 23:55:53 -0400
Received: from stanis.onastick.net ([207.96.1.49]:22539 "EHLO
	stanis.onastick.net") by vger.kernel.org with ESMTP
	id <S132573AbRDODzj>; Sat, 14 Apr 2001 23:55:39 -0400
Date: Sat, 14 Apr 2001 23:55:31 -0400
From: Disconnect <lkml@sigkill.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Athlon runtime problems
Message-ID: <20010414235531.B13205@sigkill.net>
In-Reply-To: <E14oRie-000556-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="1UWUbFP1cBYEclgG"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14oRie-000556-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> Can the folks who are seeing crashes running athlon optimised kernels all mail
> me
> -	CPU model/stepping
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1202.743

(/proc/cpuinfo attached) 1.2G Tbird

> -	Chipset

Iwill KK266, VIA KT133

> -	Amount of RAM

512M PC133 amd-approved

> -	/proc/mtrr output
reg00: base=0x00000000 (   0MB), size= 512MB: write-back, count=1
reg01: base=0xd0000000 (3328MB), size=  64MB: write-combining, count=1
reg05: base=0xd8000000 (3456MB), size=  64MB: write-combining, count=1

(This is from inside X on a K6 kernel. I can try to save it out from the
K7 kernel if needed.)

> -	compiler used

gcc version 2.95.3 20010219 (prerelease)
debian gcc 2.95.3-5

---
   _.-=<Disconnect>=-._
|     dis@sigkill.net    | And Remember...
\  shawn@healthcite.com  / He who controls Purple controls the Universe..
 PGP Key given on Request  Or at least the Purple parts!

-----BEGIN GEEK CODE BLOCK-----
Version: 3.1 [www.ebb.org/ungeek]
GIT/CC/CM/AT d--(-)@ s+:-- a-->? C++++$ ULBS*++++$ P+>+++ L++++>+++++ 
E--- W+++ N+@ o+>$ K? w--->+++++ O- M V-- PS+() PE Y+@ PGP++() t 5--- 
X-- R tv+@ b++++>$ DI++++ D++(+++) G++ e* h(-)* r++ y++
------END GEEK CODE BLOCK------

--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=cpuinfo

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 4
model name	: AMD Athlon(tm) Processor
stepping	: 2
cpu MHz		: 1202.743
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips	: 2398.61


--1UWUbFP1cBYEclgG--
