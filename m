Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964834AbVL1O7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbVL1O7Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 09:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbVL1O7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 09:59:16 -0500
Received: from waste.org ([64.81.244.121]:31442 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S964834AbVL1O7P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 09:59:15 -0500
Date: Wed, 28 Dec 2005 08:55:54 -0600
From: Matt Mackall <mpm@selenic.com>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, hch@infradead.org
Subject: Re: [PATCH 1 of 3] Introduce __memcpy_toio32
Message-ID: <20051228145553.GM3356@waste.org>
References: <patchbomb.1135726914@eng-12.pathscale.com> <7b7b442a4d6338ae8ca7.1135726915@eng-12.pathscale.com> <20051228035231.GA3356@waste.org> <1135781263.1527.89.camel@serpentine.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135781263.1527.89.camel@serpentine.pathscale.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2005 at 06:47:42AM -0800, Bryan O'Sullivan wrote:
> > > +extern void fastcall __memcpy_toio32(volatile void __iomem *to, const void *from, size_t count);
> > > +
> > 
> > Minor rant: extern is always redundant for function prototypes in C.
> 
> I know.  My intent was to keep the prototype consistent with the
> prevailing style of other declarations in that same routine.  If you
> think that cleanliness is more important, I'll be happy to change it.

No, I'm actually just raising it for discussion. I personally don't
add them, even for consistency, as I'd like to eventually see them gone.
But if Christoph and Andrew won't care, my tiny crusade is probably lost.

-- 
Mathematics is the supreme nostalgia of our time.
