Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261819AbSJAP0E>; Tue, 1 Oct 2002 11:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261852AbSJAP0D>; Tue, 1 Oct 2002 11:26:03 -0400
Received: from landfill.ihatent.com ([217.13.24.22]:8937 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S261819AbSJAP0C>;
	Tue, 1 Oct 2002 11:26:02 -0400
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       marcelo@conectiva.com.br
Subject: Re: CPU/cache detection wrong
References: <m3hegaxpp0.fsf@lapper.ihatent.com>
	<1033403655.16933.20.camel@irongate.swansea.linux.org.uk>
	<m3wup3bcgb.fsf@lapper.ihatent.com> <20020930221536.GA6987@suse.de>
	<m3smzqipzd.fsf@lapper.ihatent.com> <20021001110628.GA17865@suse.de>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 01 Oct 2002 17:31:07 +0200
In-Reply-To: <20021001110628.GA17865@suse.de>
Message-ID: <m3d6qu41ms.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@codemonkey.org.uk> writes:

> On Tue, Oct 01, 2002 at 09:21:26AM +0200, Alexander Hoogerhuis wrote:
>  > Here we go:
>  > 
>  > CPU: Trace cache: 12K uops, L1 D cache: 8K
>  > CPU: L2 cache: 512K
>  > 
>  > But my BIOS still say I should have 8Kb/8Kb I/D L1 cache... oh
>  > well. I'm sure Alan Cox would just write it up as marketing, since
>  > thats about how reliable a BIOS is :)
> 
> Hmm, can a P4 have a trace cache AND an L1 I cache ?
> I thought they were exclusive, which is why the code
> doesn't take this into account. Easily fixed if so though..
> 

I don't know the gory details of it, but my BIOS claims I got 8/8, but
I'm deep enough in it now to start taking the 5th amendment on the
details here :)

ttfn,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
