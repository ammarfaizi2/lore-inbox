Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135546AbRDXLXi>; Tue, 24 Apr 2001 07:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135547AbRDXLX1>; Tue, 24 Apr 2001 07:23:27 -0400
Received: from adsl-64-123-58-70.dsl.stlsmo.swbell.net ([64.123.58.70]:29166
	"EHLO bigandy.swbell.net") by vger.kernel.org with ESMTP
	id <S135546AbRDXLXU>; Tue, 24 Apr 2001 07:23:20 -0400
Date: Tue, 24 Apr 2001 06:19:31 -0500 (CDT)
From: Andy Carlson <naclos@swbell.net>
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: Matrox FB console driver
In-Reply-To: <Pine.LNX.4.10.10104232117410.30211-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.20.0104240616170.244-100000@bigandy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

time prime before x
real    1m23.535s
user    0m40.550s
sys     0m42.980s

/proc/mtrr before x
reg00: base=0x00000000 (   0MB), size= 256MB: write-back, count=1
reg01: base=0xfd800000 (4056MB), size=   4MB: write-combining, count=1

time prime after x
real    0m48.732s
user    0m41.070s
sys     0m7.690s

/proc/mtrr after x
reg00: base=0x00000000 (   0MB), size= 256MB: write-back, count=1
reg01: base=0xfd800000 (4056MB), size=   4MB: write-combining, count=1

time prime in X
real    0m42.835s
user    0m41.180s
sys     0m1.710s

/proc/version
Linux version 2.4.3-ac12 (root@bigandy) (gcc version 2.95.2 19991024 (release)) #15 SMP Mon Apr 23 19:35:33 CDT 2001

/proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 1
model name	: Pentium Pro
stepping	: 9
cpu MHz		: 199.312
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
bogomips	: 397.31

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 1
model name	: Pentium Pro
stepping	: 7
cpu MHz		: 199.312
cache size	: 512 KB
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


Andy Carlson                           |\      _,,,---,,_
naclos@swbell.net                ZZZzz /,`.-'`'    -.  ;-;;,_
BJC Health System                     |,4-  ) )-,_. ,\ (  `'-'
St. Louis, Missouri                  '---''(_/--'  `-'\_)
Cat Pics: http://andyc.dyndns.org

On Mon, 23 Apr 2001, Mark Hahn wrote:

> > I was playing around with a program that I was using to time differences
> > between kernels (a silly prime program that puts out 1000000 primes).  I
> > noticed a very strange behaviour.  On a fresh boot, with the Penguin
> > pictures that the Matrox FB driver puts up, the prime program runs
> > 1 minute, 30 seconds.  If I reset, it still runs 1M30S.  If I start X,
> > and exit, it runs 48 seconds.  Is this a known behaviour?  Thanks.
> 
> do you mean that running and exiting X makes your computer faster?
> is /proc/mtrr sane at both times?
> 

