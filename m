Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750904AbVKAQTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbVKAQTL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 11:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbVKAQTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 11:19:11 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:8455 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1750904AbVKAQTJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 11:19:09 -0500
Date: Tue, 1 Nov 2005 12:06:33 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] [PATCH 9/10] UML - Big memory fixes
Message-ID: <20051101170633.GB6448@ccure.user-mode-linux.org>
References: <200510310439.j9V4dgqP000878@ccure.user-mode-linux.org> <200511011611.09532.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511011611.09532.blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2005 at 04:11:04PM +0100, Blaisorblade wrote:
> I think this came up because there's (in -mm) Andi Kleen created a new zone 
> (ZONE_DMA32) for devices using 32-bit only DMA - but it seems it's not in 
> mainline).  (I don't know if that patch is in -mm actually, but I guess it 
> from this patch content).

Correct, nice spotting.

This chunk leaked from my -mm tree accidentally, so it is appropriate for -mm,
but it should be its own separate -mm-only patch.

				Jeff
