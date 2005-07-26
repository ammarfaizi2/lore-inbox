Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbVG0SiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVG0SiY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 14:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVG0Sfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 14:35:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:64672 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262435AbVG0SdN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 14:33:13 -0400
Date: Tue, 26 Jul 2005 16:50:49 -0700
From: Greg KH <greg@kroah.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: akpm@osdl.org, linux-pcmcia@lists.infradead.org,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 8/8] pci and yenta: pcibios_bus_to_resource
Message-ID: <20050726235049.GB6584@kroah.com>
References: <20050711222138.GH30827@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050711222138.GH30827@isilmar.linta.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2005 at 12:21:38AM +0200, Dominik Brodowski wrote:
> In yenta_socket, we default to using the resource setting of the CardBus
> bridge. However, this is a PCI-bus-centric view of resources and thus
> needs to be converted to generic resources first. Therefore, add a call
> to pcibios_bus_to_resource() call in between. This function is a mere
> wrapper on x86 and friends, however on some others it already exists, is
> added in this patch (alpha, arm, ppc, ppc64) or still needs to be 
> provided (parisc -- where is its pcibios_resource_to_bus() ?).
> 
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

Hm, I saw a few different patches here, and some odd complaints.  Care
to resend an updated version?

thanks,

greg k-h
