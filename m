Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283278AbRK2PeF>; Thu, 29 Nov 2001 10:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280664AbRK2Pd4>; Thu, 29 Nov 2001 10:33:56 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:3726 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S283275AbRK2Pdw>; Thu, 29 Nov 2001 10:33:52 -0500
Date: Thu, 29 Nov 2001 08:33:23 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Christoph Hellwig <hch@caldera.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Samuel Maftoul <maftoul@esrf.fr>, linux-kernel@vger.kernel.org
Subject: Re: rpm builder of kernel image
Message-ID: <20011129083323.T29541@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <200111291358.fATDwSh32089@ns.caldera.de> <E169Szk-0000JN-00@the-village.bc.nu> <20011129161519.A9688@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011129161519.A9688@caldera.de>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2001 at 04:15:20PM +0100, Christoph Hellwig wrote:
> On Thu, Nov 29, 2001 at 03:21:00PM +0000, Alan Cox wrote:
> > > You might want to take a look at make-krpm [1], currently I only have
> > > support for Caldera and a default target that might work or not work
> > > for others.  I accept patches..
> > 
> > Or for Linux 2.4.13 or later just type
> > 
> > 	make config
> > 	make rpm
> 
> Yes, that's even older than my tool.  But I don't think we want that
> infrastructure inside the kernel.
> 
>  - there are lots of packaging systems
>  - there even are lots of incompatible rpm versions
>  - you really want to plug into some vendor-infrastructure, e.g.
>    boot loader configuration
>  - sooner or later I want to add some system to auto-apply patches
>    (similar to what debian does)
- there are other architectures which have rpm based distros.  'make
  rpm' is currently x86-only.

This really should be a vendor-provided tool, or at least something
provided outside of the kernel by 3rd parties.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
