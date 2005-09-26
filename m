Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbVIZIQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbVIZIQG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 04:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbVIZIQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 04:16:06 -0400
Received: from witte.sonytel.be ([80.88.33.193]:51680 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S932429AbVIZIQF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 04:16:05 -0400
Date: Mon, 26 Sep 2005 10:15:25 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
cc: Christoph Hellwig <hch@infradead.org>, Brian Gerst <bgerst@didntduck.org>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CONFIG_IA32
In-Reply-To: <Pine.LNX.4.61.0509251116430.1684@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.62.0509261014360.6022@numbat.sonytel.be>
References: <4335DD14.7090909@didntduck.org> <20050925100525.GA14741@infradead.org>
 <Pine.LNX.4.61.0509251116430.1684@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Sep 2005, Zwane Mwaikambo wrote:
> On Sun, 25 Sep 2005, Christoph Hellwig wrote:
> > On Sat, Sep 24, 2005 at 07:11:16PM -0400, Brian Gerst wrote:
> > > Add CONFIG_IA32 for i386.  This allows selecting options that only apply 
> > > to 32-bit systems.
> > > 
> > > (X86 && !X86_64) becomes IA32
> > > (X86 ||  X86_64) becomes X86
> > 
> > Please call it X86_32 or I386, to match the terminology we use everywhere.
> > I386 would match the uname, and X86_32 would be the logical countepart
> > to X86_64.
> 
> ia32 has been in use much longer than x86_32 and more ubiquitous.

Yes, but x86_64 supports ia32, so ia32 is not a good name for (X86 && !X86_64).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
