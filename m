Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267313AbSKPR3d>; Sat, 16 Nov 2002 12:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267314AbSKPR3d>; Sat, 16 Nov 2002 12:29:33 -0500
Received: from waste.org ([209.173.204.2]:60139 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S267313AbSKPR3c>;
	Sat, 16 Nov 2002 12:29:32 -0500
Date: Sat, 16 Nov 2002 11:35:52 -0600
From: Oliver Xymoron <oxymoron@waste.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: William Lee Irwin III <wli@holomorphy.com>, Pavel Machek <pavel@suse.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swsuspend and CONFIG_DISCONTIGMEM=y
Message-ID: <20021116173552.GF19061@waste.org>
References: <20021115081044.GI18180@conectiva.com.br> <20021115084915.GS23425@holomorphy.com> <20021115094827.GT23425@holomorphy.com> <20021115120233.GC25902@atrey.karlin.mff.cuni.cz> <1037366172.877.30.camel@zion> <20021115181247.GB8763@elf.ucw.cz> <20021115185632.GY23425@holomorphy.com> <1037414484.21974.17.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037414484.21974.17.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 16, 2002 at 02:41:24AM +0000, Alan Cox wrote:
> On Fri, 2002-11-15 at 18:56, William Lee Irwin III wrote:
> > But like I said, it's very unlikely any strong interest will ever
> > arise specifically in large-scale i386 checkpointing. Computational
> > workloads are very attached to having clean and efficient FPU's, which
> > i386 lacks. RISC etc. boxen with clean FPU's are more important for
> > that. OTOH if highmem works, why wouldn't bigger highmem boxen work? NFI
> 
> Most large scale FP computation jobs are done on x86. RISC stuff isnt
> that much faster if at all. It may be elegant but the PIV and Athlon go
> at 2.5Ghz so make up for elegance by being stupid very fast (note that
> by the PIV and athlon the FPU's are not actually very veryy smart)

Their built-in trancendental ops still beat the pants off RISC clock
for clock, so even at the same clock rate, some number crunching stuff
still wins big on x86. Throw in the cost/FLOPS difference and its
little wonder that very few big machines are being built with anything
but.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
