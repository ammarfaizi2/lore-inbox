Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbUCIEzo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 23:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbUCIEzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 23:55:43 -0500
Received: from fed1mtao08.cox.net ([68.6.19.123]:20127 "EHLO
	fed1mtao08.cox.net") by vger.kernel.org with ESMTP id S261537AbUCIEzn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 23:55:43 -0500
Date: Mon, 8 Mar 2004 21:55:41 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: linux-kernel@vger.kernel.org
Subject: Re: pci_set_dma_mask()/pci_dma_supported() & broken PCI bridge issue
Message-ID: <20040309045541.GA9718@plexity.net>
Reply-To: dsaxena@plexity.net
References: <20040309044138.GA9491@plexity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040309044138.GA9491@plexity.net>
User-Agent: Mutt/1.3.28i
Organization: Plexity Networks
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 08 2004, at 21:41, Deepak Saxena was caught saying:
> 
> I am a bit confused about the proper way that dma_set_mask() should
> behave. My situation is that I have an ARM core that has broken
> PCI window, allowing DMA only to/from the lower 64MB of RAM. My
> current approach to get around this is custom dma-API functions
> that trap based on (dev->bus == &pci_bus_type && *dev->dma_mask !=
> 0xfffffff). If dma_mask is 0xfffffff, I use the generic ARM dma API

I meant 0xffffffff

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/
