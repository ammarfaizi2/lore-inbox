Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316842AbSHGEIx>; Wed, 7 Aug 2002 00:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316853AbSHGEIx>; Wed, 7 Aug 2002 00:08:53 -0400
Received: from holomorphy.com ([66.224.33.161]:26770 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316842AbSHGEIw>;
	Wed, 7 Aug 2002 00:08:52 -0400
Date: Tue, 6 Aug 2002 21:12:39 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: fix CONFIG_HIGHPTE
Message-ID: <20020807041239.GB15685@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rik van Riel <riel@conectiva.com.br>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
References: <20020807013152.GA15685@holomorphy.com> <Pine.LNX.4.44L.0208070059380.23404-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0208070059380.23404-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2002 at 09:50:50PM -0300, Rik van Riel wrote:
>>> For all workloads we care about, yes.

On Tue, 6 Aug 2002, William Lee Irwin III wrote:
>> Not the university workload. NFI what my employer thinks of it, but I
>> care about it for the sake of correctness in all cases.
>> Lynch me now.

On Wed, Aug 07, 2002 at 01:00:28AM -0300, Rik van Riel wrote:
> I agree with you, but you'll also have to confess that keeping
> pagetables around at all (whether it's in highmem or not) will
> potentially be a disaster for the university workload.
> regards,
> Rik

That's pretty much the point of it, yes.

... coincidentally, this is also needed to properly handle the vastness
of 64-bit address spaces in comparison to physical memory.


Cheers,
Bill
