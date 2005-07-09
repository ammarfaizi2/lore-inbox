Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263060AbVGIBAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263060AbVGIBAQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 21:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263061AbVGIA6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 20:58:01 -0400
Received: from ns.suse.de ([195.135.220.2]:686 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S263060AbVGIA4i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 20:56:38 -0400
Date: Sat, 9 Jul 2005 02:56:38 +0200
From: Andi Kleen <ak@suse.de>
To: Jon Schindler <jonschindler@hotmail.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: USB storage does not work with 3GB of RAM, but does with 2G of RAM
Message-ID: <20050709005638.GE21330@wotan.suse.de>
References: <p734qb5p04e.fsf@verdi.suse.de> <BAY20-F7EE6B3C3A0E5C80A183D7C4DA0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY20-F7EE6B3C3A0E5C80A183D7C4DA0@phx.gbl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2005 at 08:49:12PM -0400, Jon Schindler wrote:
> Hi Andi,
> 
> As you suggested, removing ehci_hcd (using rmmod ehci_hcd) allows the USB 
> storage device to work.  So, to answer your question, yes, the ohci_hcd 
> driver does work with 3GB's of RAM.  Still, knoppix 3.9 IS able to work 
> with both ehci and 3GB's of RAM, so it still sounds like it's a software 
> problem, not an nvidia hardware issue.

Knoppix is 32bit I guess. The 32bit kernel will do a lot of DMA
only in the first 800-900MB (lowmem) 

-Andi

