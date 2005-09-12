Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbVILMyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbVILMyn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 08:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbVILMyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 08:54:43 -0400
Received: from cantor2.suse.de ([195.135.220.15]:30910 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750797AbVILMym (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 08:54:42 -0400
From: Andi Kleen <ak@suse.de>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [1/3] Add 4GB DMA32 zone
Date: Mon, 12 Sep 2005 14:54:34 +0200
User-Agent: KMail/1.8
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <43246267.mailL4R11PXCB@suse.de> <200509121447.00373.ak@suse.de> <Pine.LNX.4.61.0509121449590.3728@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0509121449590.3728@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509121454.37220.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 September 2005 14:50, Roman Zippel wrote:
> Hi,
>
> On Mon, 12 Sep 2005, Andi Kleen wrote:
> > > > -#define MAX_NR_ZONES		3	/* Sync this with ZONES_SHIFT */
> > > > -#define ZONES_SHIFT		2	/* ceil(log2(MAX_NR_ZONES)) */
> > > > +#define MAX_NR_ZONES		4	/* Sync this with ZONES_SHIFT */
> > > > +#define ZONES_SHIFT		3	/* ceil(log2(MAX_NR_ZONES)) */
> > >
> > > Why needs ZONES_SHIFT to be increased?
> > >
> > > > -#define FLAGS_RESERVED		8
> > > > +#define FLAGS_RESERVED		9
> > >
> > > I would prefer to keep this at 8.
> >
> > sparsemem needs these two.
>
> What two? What are you talking about???

The two changes you quoted.

-Andi
