Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267202AbSKPCIE>; Fri, 15 Nov 2002 21:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267203AbSKPCIE>; Fri, 15 Nov 2002 21:08:04 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:46768 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267202AbSKPCIE>; Fri, 15 Nov 2002 21:08:04 -0500
Subject: Re: [PATCH] swsuspend and CONFIG_DISCONTIGMEM=y
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Pavel Machek <pavel@suse.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021115185632.GY23425@holomorphy.com>
References: <20021115081044.GI18180@conectiva.com.br>
	<20021115084915.GS23425@holomorphy.com>
	<20021115094827.GT23425@holomorphy.com>
	<20021115120233.GC25902@atrey.karlin.mff.cuni.cz>
	<1037366172.877.30.camel@zion> <20021115181247.GB8763@elf.ucw.cz> 
	<20021115185632.GY23425@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 16 Nov 2002 02:41:24 +0000
Message-Id: <1037414484.21974.17.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-15 at 18:56, William Lee Irwin III wrote:
> But like I said, it's very unlikely any strong interest will ever
> arise specifically in large-scale i386 checkpointing. Computational
> workloads are very attached to having clean and efficient FPU's, which
> i386 lacks. RISC etc. boxen with clean FPU's are more important for
> that. OTOH if highmem works, why wouldn't bigger highmem boxen work? NFI

Most large scale FP computation jobs are done on x86. RISC stuff isnt
that much faster if at all. It may be elegant but the PIV and Athlon go
at 2.5Ghz so make up for elegance by being stupid very fast (note that
by the PIV and athlon the FPU's are not actually very veryy smart)

Alan

