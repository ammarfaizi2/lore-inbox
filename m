Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbTJ0Pi0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 10:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262913AbTJ0Pi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 10:38:26 -0500
Received: from havoc.gtf.org ([63.247.75.124]:55220 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262802AbTJ0PiZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 10:38:25 -0500
Date: Mon, 27 Oct 2003 10:38:24 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Keith Whitwell <keith@tungstengraphics.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Egbert Eich <eich@xfree86.org>,
       Jon Smirl <jonsmirl@yahoo.com>, Eric Anholt <eta@lclark.edu>,
       kronos@kronoz.cjb.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net,
       dri-devel <dri-devel@lists.sourceforge.net>
Subject: Re: [Dri-devel] Re: [Linux-fbdev-devel] DRM and pci_driver conversion
Message-ID: <20031027153824.GA19711@gtf.org>
References: <Pine.LNX.4.44.0310251116140.4083-100000@home.osdl.org> <3F9ACC58.5010707@pobox.com> <3F9D3643.9030400@tungstengraphics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F9D3643.9030400@tungstengraphics.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 27, 2003 at 03:14:11PM +0000, Keith Whitwell wrote:
> Jeff Garzik wrote:
> >Thank you for saying it.  This is what I have been preaching (quietly) 
> >for years -- command submission and synchronization (and thus, DMA/irq 
> >handling) needs to be in the kernel.  Everything else can be in 
> >userspace (excluding hardware enable/enumerate, of course).
> 
> To enable secure direct rendering on current hardware (ie without secure 
> command submission mechanisms), you need command valididation somewhere.  
> This could be a layer on top of the minimal dma engine Linus describes.

Certainly.


> >Graphics processors are growing more general, too -- moving towards 
> >generic vector/data processing engines.  I bet you'll see an optimal 
> >model emerge where you have some sort of "JIT" for GPU microcode in 
> >userspace.  
> 
> You mean like the programmable fragment and vertex hardware that has been 
> in use for a couple of years now?

I mean, taking current fragment and vertex processing and making it
even _more_ general.  Which has already happened, on one particular chip
maker's chip...

	Jeff



