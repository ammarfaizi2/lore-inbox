Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316845AbSHGD5Q>; Tue, 6 Aug 2002 23:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316853AbSHGD5P>; Tue, 6 Aug 2002 23:57:15 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:30477 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S316845AbSHGD5L>; Tue, 6 Aug 2002 23:57:11 -0400
Date: Wed, 7 Aug 2002 01:00:28 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Andrew Morton <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: fix CONFIG_HIGHPTE
In-Reply-To: <20020807013152.GA15685@holomorphy.com>
Message-ID: <Pine.LNX.4.44L.0208070059380.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Aug 2002, William Lee Irwin III wrote:
> On Tue, 6 Aug 2002, Andrew Morton wrote:
> >> Is it likely that large pages and/or shared pagetables would allow us to
> >> place pagetables and pte_chains in the direct-mapped region, avoid all
> >> this?
>
> On Tue, Aug 06, 2002 at 09:50:50PM -0300, Rik van Riel wrote:
> > For all workloads we care about, yes.
>
> Not the university workload. NFI what my employer thinks of it, but I
> care about it for the sake of correctness in all cases.
>
> Lynch me now.

I agree with you, but you'll also have to confess that keeping
pagetables around at all (whether it's in highmem or not) will
potentially be a disaster for the university workload.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

