Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316822AbSHGEEE>; Wed, 7 Aug 2002 00:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316842AbSHGEEE>; Wed, 7 Aug 2002 00:04:04 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:59150 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S316822AbSHGEED>; Wed, 7 Aug 2002 00:04:03 -0400
Date: Wed, 7 Aug 2002 01:05:25 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Anton Blanchard <anton@samba.org>
cc: Andrew Morton <akpm@zip.com.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: fix CONFIG_HIGHPTE
In-Reply-To: <20020807010752.GC6343@krispykreme>
Message-ID: <Pine.LNX.4.44L.0208070104490.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2002, Anton Blanchard wrote:

> On ppc64 shared pagetables will require significant changes to the way
> we handle the hardware hashtable. So add that to the "more and more crap
> in there to support these pte_chains"
>
> Will shared pagetables be a requirement or can we turn it on per arch?

Sharing the logical page table doesn't mean you'll have to do
the same for the PPC hashed page table...

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

