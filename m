Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283265AbRK2PQZ>; Thu, 29 Nov 2001 10:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283266AbRK2PQP>; Thu, 29 Nov 2001 10:16:15 -0500
Received: from ns.caldera.de ([212.34.180.1]:34948 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S283265AbRK2PQE>;
	Thu, 29 Nov 2001 10:16:04 -0500
Date: Thu, 29 Nov 2001 16:15:20 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Samuel Maftoul <maftoul@esrf.fr>, linux-kernel@vger.kernel.org
Subject: Re: rpm builder of kernel image
Message-ID: <20011129161519.A9688@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Samuel Maftoul <maftoul@esrf.fr>, linux-kernel@vger.kernel.org
In-Reply-To: <200111291358.fATDwSh32089@ns.caldera.de> <E169Szk-0000JN-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E169Szk-0000JN-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Nov 29, 2001 at 03:21:00PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2001 at 03:21:00PM +0000, Alan Cox wrote:
> > You might want to take a look at make-krpm [1], currently I only have
> > support for Caldera and a default target that might work or not work
> > for others.  I accept patches..
> 
> Or for Linux 2.4.13 or later just type
> 
> 	make config
> 	make rpm

Yes, that's even older than my tool.  But I don't think we want that
infrastructure inside the kernel.

 - there are lots of packaging systems
 - there even are lots of incompatible rpm versions
 - you really want to plug into some vendor-infrastructure, e.g.
   boot loader configuration
 - sooner or later I want to add some system to auto-apply patches
   (similar to what debian does)
