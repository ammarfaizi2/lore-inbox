Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267212AbSKPDCS>; Fri, 15 Nov 2002 22:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267213AbSKPDCS>; Fri, 15 Nov 2002 22:02:18 -0500
Received: from holomorphy.com ([66.224.33.161]:13267 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267212AbSKPDCR>;
	Fri, 15 Nov 2002 22:02:17 -0500
Date: Fri, 15 Nov 2002 19:06:05 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pavel Machek <pavel@suse.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swsuspend and CONFIG_DISCONTIGMEM=y
Message-ID: <20021116030605.GD23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@suse.cz>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021115081044.GI18180@conectiva.com.br> <20021115084915.GS23425@holomorphy.com> <20021115094827.GT23425@holomorphy.com> <20021115120233.GC25902@atrey.karlin.mff.cuni.cz> <1037366172.877.30.camel@zion> <20021115181247.GB8763@elf.ucw.cz> <20021115185632.GY23425@holomorphy.com> <1037414484.21974.17.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037414484.21974.17.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 16, 2002 at 02:41:24AM +0000, Alan Cox wrote:
> Most large scale FP computation jobs are done on x86. RISC stuff isnt
> that much faster if at all. It may be elegant but the PIV and Athlon go
> at 2.5Ghz so make up for elegance by being stupid very fast (note that
> by the PIV and athlon the FPU's are not actually very veryy smart)

The clock speeds of i386 may very well now be up to the point where its
clock speeds dominate all other considerations. But I've never seen
large-scale i386 machines used in what numerics I've been involved in,
which, granted, was not much and several years ago (SGI dominated).

I'm still somewhat skeptical given the cpu counts, process address
space, and I/O architecture limitations on i386, but I don't honestly
care. Numerics is not my game anymore if it ever was, and whatever
additional functionality might come out of cleanups is only ammunition
to push the cleanups to me.


Bill
