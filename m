Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbVILMu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbVILMu5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 08:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbVILMu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 08:50:57 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:18390 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750794AbVILMu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 08:50:57 -0400
Date: Mon, 12 Sep 2005 14:50:54 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andi Kleen <ak@suse.de>
cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [1/3] Add 4GB DMA32 zone
In-Reply-To: <200509121447.00373.ak@suse.de>
Message-ID: <Pine.LNX.4.61.0509121449590.3728@scrub.home>
References: <43246267.mailL4R11PXCB@suse.de> <Pine.LNX.4.61.0509121430510.3743@scrub.home>
 <200509121447.00373.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 12 Sep 2005, Andi Kleen wrote:

> > > -#define MAX_NR_ZONES		3	/* Sync this with ZONES_SHIFT */
> > > -#define ZONES_SHIFT		2	/* ceil(log2(MAX_NR_ZONES)) */
> > > +#define MAX_NR_ZONES		4	/* Sync this with ZONES_SHIFT */
> > > +#define ZONES_SHIFT		3	/* ceil(log2(MAX_NR_ZONES)) */
> >
> > Why needs ZONES_SHIFT to be increased?
> >
> > > -#define FLAGS_RESERVED		8
> > > +#define FLAGS_RESERVED		9
> >
> > I would prefer to keep this at 8.
> 
> sparsemem needs these two.

What two? What are you talking about???

bye, Roman
