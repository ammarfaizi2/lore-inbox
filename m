Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130893AbRBWJ7x>; Fri, 23 Feb 2001 04:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131025AbRBWJ7n>; Fri, 23 Feb 2001 04:59:43 -0500
Received: from ns.suse.de ([213.95.15.193]:58640 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130893AbRBWJ7a>;
	Fri, 23 Feb 2001 04:59:30 -0500
Date: Fri, 23 Feb 2001 10:59:28 +0100
From: Olaf Hering <olh@suse.de>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Boot log for Linux PPC64 on POWER3 hardware
Message-ID: <20010223105928.C23409@suse.de>
In-Reply-To: <3A95AB71.FCECB41F@us.ibm.com> <20010223001402.A19464@cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010223001402.A19464@cadcamlab.org>; from peter@cadcamlab.org on Fri, Feb 23, 2001 at 12:14:02AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, Peter Samuelson wrote:

> 
> [Peter Bergner]
> > The following is a boot log for a 64 bit port of Linux for IBM's 64
> > bit PowerPC processors.  This log was made on a pSeries model 270
> > which uses a POWER3 microprocessor.
> 
> Impressive.  One question, though --
> 
> > starting cpu /cpus/PowerPC,POWER3@1...ok
> > starting cpu /cpus/PowerPC,POWER3@2...ok
> > starting cpu /cpus/PowerPC,POWER3@3...ok
> 
> You have 4 CPUs?

It has 4 CPUs.

> > OpenPIC Version 1.2 (8 CPUs and 32 IRQ sources) at e000000001002000
> > OpenPIC timer frequency is 0 MHz
> 
> ...or is it 8 CPUs?

The controller can handle 8 CPUs.

> > swamsauger:~ # uname -a
> > Linux swamsauger 2.4.0-tg11 #188 Thu Feb 22 19:55:45 CST 2001 ppc64 unknown
> > swamsauger:~ # 
> > swamsauger:~ # cat /proc/cpuinfo 
> > processor       : 0
> 
> ...or just one CPU?

The (native) 64bit port can handle only one CPU right now.

mandarine:~/kernel # cat /proc/cpuinfo 
processor       : 0
cpu             : POWER3 (630+)
clock           : 375MHz
revision        : 1.4
bogomips        : 749.24

processor       : 1
cpu             : POWER3 (630+)
clock           : 375MHz
revision        : 1.4
bogomips        : 749.24

processor       : 2
cpu             : POWER3 (630+)
clock           : 375MHz
revision        : 1.4
bogomips        : 749.24

processor       : 3
cpu             : POWER3 (630+)
clock           : 375MHz
revision        : 1.4
bogomips        : 749.24

total bogomips  : 2995.49
zero pages      : total: 0 (0Kb) current: 0 (0Kb) hits: 0/0 (0%)
machine         : CHRP IBM,7026-B80

Thats the power3 kernel in 32bit emulation mode for that 64bit CPU.




Gruss Olaf

-- 
 $ man clone

BUGS
       Main feature not yet implemented...
