Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262379AbVAVBVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbVAVBVG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 20:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbVAVBVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 20:21:06 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:43757 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262342AbVAVBVC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 20:21:02 -0500
Date: Sat, 22 Jan 2005 02:20:49 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>
cc: Paul Mackerras <paulus@samba.org>, clameter@sgi.com, davem@davemloft.net,
       hugh@veritas.com, linux-ia64@vger.kernel.org, torvalds@osdl.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Extend clear_page by an order parameter
In-Reply-To: <20050121164353.6f205fbc.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0501220219390.6118@scrub.home>
References: <Pine.LNX.4.58.0501041512450.1536@schroedinger.engr.sgi.com>
 <Pine.LNX.4.44.0501082103120.5207-100000@localhost.localdomain>
 <20050108135636.6796419a.davem@davemloft.net>
 <Pine.LNX.4.58.0501211210220.25925@schroedinger.engr.sgi.com>
 <16881.33367.660452.55933@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.58.0501211545080.27045@schroedinger.engr.sgi.com>
 <16881.40893.35593.458777@cargo.ozlabs.ibm.com> <20050121164353.6f205fbc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 21 Jan 2005, Andrew Morton wrote:

> Paul Mackerras <paulus@samba.org> wrote:
> >
> > A cluster of 2^n contiguous pages
> >  isn't one page by any normal definition.
> 
> It is, actually, from the POV of the page allocator.  It's a "higher order
> page" and is controlled by a struct page*, just like a zero-order page...

OTOH we also have alloc_page/alloc_pages.

bye, Roman
