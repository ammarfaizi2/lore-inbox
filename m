Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262349AbTIAEt0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 00:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262567AbTIAEt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 00:49:26 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:31881 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262349AbTIAEtZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 00:49:25 -0400
Date: Mon, 1 Sep 2003 05:49:23 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030901044923.GC748@mail.jlokier.co.uk>
References: <20030829053510.GA12663@mail.jlokier.co.uk> <20030829100348.GA5417@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030829100348.GA5417@werewolf.able.es>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:
> On 08.29, Jamie Lokier wrote:
> > I already got a surprise (to me): my Athlon MP is much slower
> > accessing multiple mappings which are within 32k of each other, than
> > mappings which are further apart, although it is coherent.  The L1
> > data cache is 64k.  (The explanation is easy: virtually indexed,
> > physically tagged cache moves data among cache lines, possibly via L2).
> > 
> 
> Sorry if this is a stupid question, but have you heard about 64K-aliasing ?
> We have seen it in P3/P4, do not know if Athlons also suffer it.
> In short, x86 is crap. It slows like a dog when accessing two memory
> positions sparated by 2^n (address decoder has two 16 bits adders, instead
> of 1 32 bits..., cache is 16 bit tagged, etc...)

I don't know what you mean.  This test doesn't observe any gross
timing effect at 64K.  I have just tried it on a Celeron Coppermine
printing more detailed numbers, and I don't notice anything at all.

So, what exactly do you mean?  What kind of code shows the effect you
are talking about?

Thanks,
-- Jamie
