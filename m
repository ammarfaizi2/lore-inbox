Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265111AbRGEM7l>; Thu, 5 Jul 2001 08:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265100AbRGEM7a>; Thu, 5 Jul 2001 08:59:30 -0400
Received: from linux.kappa.ro ([194.102.255.131]:5014 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id <S265101AbRGEM7W>;
	Thu, 5 Jul 2001 08:59:22 -0400
X-RAV-AntiVirus: This e-mail has been scanned for viruses on host: linux.kappa.ro
Date: Thu, 5 Jul 2001 16:00:27 +0300
From: Mircea Damian <dmircea@kappa.ro>
To: Thibaut Laurent <thibaut@celestix.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: [2.4.6] kernel BUG at softirq.c:206!
Message-ID: <20010705160027.A14170@linux.kappa.ro>
In-Reply-To: <20010704232816.B590@marvin.mahowi.de> <20010705104650.A2820@linux.kappa.ro> <20010705185243.2e3a942e.thibaut@celestix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010705185243.2e3a942e.thibaut@celestix.com>; from thibaut@celestix.com on Thu, Jul 05, 2001 at 06:52:43PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2001 at 06:52:43PM +0800, Thibaut Laurent wrote:
> Hi,
> 
> I posted a message 2 weeks ago regarding this bug, though I can't trigger the
> kernel panic every time (see original post). My CPU is a MediaGX, and
> Manfred's one is a 6x86MX. What about yours ?
> After my first unsuccessful attempt with a 2.4.6-pre3, I tried several other
> 2.4.6-preX and 2.4.5-acX kernels. All 2.4.6 (since pre1) seem to be
> affected, and so do the latest ac's. I don't have tested 2.4.7-pre[12] yet,
> but looking at the changelog, I doubt the fix is in.

My CPU is:

root@cyrix:~# cat /proc/cpuinfo 
processor       : 0
vendor_id       : CyrixInstead
cpu family      : 6
model           : 2
model name      : 6x86MX 2.5x Core/Bus Clock
stepping        : 7
cpu MHz         : 166.452
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : yes
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu de tsc msr cx8 pge cmov mmx cyrix_arr
bogomips        : 331.77



-- 
Mircea Damian
E-mails: dmircea@kappa.ro, dmircea@roedu.net
WebPage: http://taz.mania.k.ro/~dmircea/
