Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267651AbUIHNdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267651AbUIHNdL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 09:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267615AbUIHNaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 09:30:10 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:2024 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S267659AbUIHN3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 09:29:37 -0400
Date: Wed, 8 Sep 2004 09:34:03 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Scott Wood <scott@timesys.com>
Subject: Re: [patch] generic-hardirqs.patch, 2.6.9-rc1-bk14
In-Reply-To: <20040908125755.GC3106@holomorphy.com>
Message-ID: <Pine.LNX.4.53.0409080932050.15087@montezuma.fsmlabs.com>
References: <20040908120613.GA16916@elte.hu> <20040908133445.A31267@infradead.org>
 <20040908124547.GA19231@elte.hu> <20040908125755.GC3106@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Sep 2004, William Lee Irwin III wrote:

> * Christoph Hellwig <hch@infradead.org> wrote:
> >> And make hardirq.o dependent on some symbols the architectures set.
> >> Else arches that don't use it carry tons of useless baggage around
> >> (and in fact I'm pretty sure it wouldn't even compie for many)
> 
> On Wed, Sep 08, 2004 at 02:45:47PM +0200, Ingo Molnar wrote:
> > it compiles fine on x86, x64, ppc and ppc64. Why do you think it wont
> > compile on others?
> > wrt. unused generic functions - why dont we drop them link-time?
> 
> It may be time for a __weak define to abbreviate __attribute__((weak));
> we seem to use it in enough places.

Hmm, whenever i've brought up weak functions in a patch it's never well 
received. Frankly i prefer it to littering the architectures with similar 
functions.

	Zwane

