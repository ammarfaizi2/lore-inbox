Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271929AbRIEJ7Z>; Wed, 5 Sep 2001 05:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271953AbRIEJ7N>; Wed, 5 Sep 2001 05:59:13 -0400
Received: from techmonkeys.org ([24.72.12.135]:29880 "EHLO techmonkeys.org")
	by vger.kernel.org with ESMTP id <S271929AbRIEJ6x>;
	Wed, 5 Sep 2001 05:58:53 -0400
Date: Wed, 5 Sep 2001 03:59:10 -0600
From: "Matthew S . Hallacy" <poptix@techmonkeys.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Athlon doesn't like Athlon optimisation?
Message-ID: <20010905035910.L20505@techmonkeys.org>
In-Reply-To: <200109050521.WAA26155@equinox.unr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200109050521.WAA26155@equinox.unr.edu>; from ejolson@unr.edu on Tue, Sep 04, 2001 at 10:21:58PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2001 at 10:21:58PM -0700, Eric Olson wrote:
> 
> Robert Redelmeier told me he has written a version of his burnMMX which 
> uses K7 MMX 3DNow streaming cache bypass load/store instruction sequences
> similar to what is used in linux/arch/i386/lib/mmx.c
> 

I'm happy to report that after leaving these (burnK7, and burnMMX) running for about 
30 minutes there were no problems, a slight increase in CPU/system temperature, but 
within safe limits, along with a nice load average.. FYI:

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 4
cpu MHz         : 1327.702
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2647.65

note this is the "c" core chip,
256M DDR RAM,
PC Chips M830LR motherboard w/ the SiS 735 Chipset,
(note, my single-chip chipset requires no fan, unlike the VIA chipsets)

All rather well considering the CPU fan is missing two blades, and only has the little
pink patch of thermal grease.



				Matthew S. Hallacy

-- 
