Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264265AbUFXLgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbUFXLgI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 07:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264270AbUFXLgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 07:36:08 -0400
Received: from cantor.suse.de ([195.135.220.2]:56746 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264265AbUFXLgH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 07:36:07 -0400
Date: Thu, 24 Jun 2004 13:29:00 +0200
From: Andi Kleen <ak@suse.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: Andi Kleen <ak@muc.de>, Terence Ripperda <tripperda@nvidia.com>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: [discuss] Re: 32-bit dma allocations on 64-bit platforms
Message-ID: <20040624112900.GE16727@wotan.suse.de>
References: <m3acyu6pwd.fsf@averell.firstfloor.org> <20040623213643.GB32456@hygelac> <20040623234644.GC38425@colin2.muc.de> <s5hhdt1i4yc.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hhdt1i4yc.wl@alsa2.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can't it be called with GFP_KERNEL at first, then with GFP_DMA if the
> allocated pages are out of dma mask, just like in pci-gart.c?
> (with ifdef x86-64)

That won't work reliable enough in extreme cases.

-Andi
