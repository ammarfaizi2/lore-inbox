Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261504AbSJAHQ0>; Tue, 1 Oct 2002 03:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261505AbSJAHQ0>; Tue, 1 Oct 2002 03:16:26 -0400
Received: from landfill.ihatent.com ([217.13.24.22]:2025 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S261504AbSJAHQX>;
	Tue, 1 Oct 2002 03:16:23 -0400
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       marcelo@conectiva.com.br
Subject: Re: CPU/cache detection wrong
References: <m3hegaxpp0.fsf@lapper.ihatent.com>
	<1033403655.16933.20.camel@irongate.swansea.linux.org.uk>
	<m3wup3bcgb.fsf@lapper.ihatent.com> <20020930221536.GA6987@suse.de>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 01 Oct 2002 09:21:26 +0200
In-Reply-To: <20020930221536.GA6987@suse.de>
Message-ID: <m3smzqipzd.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@codemonkey.org.uk> writes:

> On Mon, Sep 30, 2002 at 07:43:16PM +0200, Alexander Hoogerhuis wrote:
> 
>  > PU: Before vendor init, caps: 3febf9ff 00000000 00000000, vendor = 0
>  > Cache info byte: 50
> 
> Instruction TLB (ignored)
> 
>  > Cache info byte: 5B
> 
> Data TLB (ignored)
> 
>  > Cache info byte: 66
> 
> 8K L1 data cache
>  
>  > Cache info byte: 00
>  > Cache info byte: 00
>  > Cache info byte: 00
>  > Cache info byte: 00
>  > Cache info byte: 00
>  > Cache info byte: 00
>  > Cache info byte: 00
>  > Cache info byte: 00
> 
> Null
>  
>  > Cache info byte: 40
> 
> No 3rd level cache.
> 
>  > Cache info byte: 70
> 
> 12K-uops trace cache
> 
>  > Cache info byte: 7B
> 
> 512K L2 cache
> 
>  > Cache info byte: 00
> 
> Null.
>  
>  > CPU: L1 I cache: 0K, L1 D cache: 8K
>  > CPU: L2 cache: 512K
> 

Here we go:

CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K

But my BIOS still say I should have 8Kb/8Kb I/D L1 cache... oh
well. I'm sure Alan Cox would just write it up as marketing, since
thats about how reliable a BIOS is :)

ttfn,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
