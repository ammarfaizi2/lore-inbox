Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265916AbTF3VBL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 17:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265917AbTF3VBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 17:01:10 -0400
Received: from [66.212.224.118] ([66.212.224.118]:17160 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S265916AbTF3VBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 17:01:07 -0400
Date: Mon, 30 Jun 2003 17:04:20 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Mel Gorman <mel@csn.ul.ie>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.5.73 Scheduling while atomic with taskfile IO and high
 memory
In-Reply-To: <Pine.LNX.4.53.0306302052520.22576@skynet>
Message-ID: <Pine.LNX.4.53.0306301702150.2299@montezuma.mastecende.com>
References: <Pine.LNX.4.53.0306302052520.22576@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jun 2003, Mel Gorman wrote:

> # CONFIG_BLK_DEV_AEC62XX is not set
> # CONFIG_BLK_DEV_ALI15X3 is not set
> # CONFIG_BLK_DEV_AMD74XX is not set
> # CONFIG_BLK_DEV_CMD64X is not set
> # CONFIG_BLK_DEV_TRIFLEX is not set
> # CONFIG_BLK_DEV_CY82C693 is not set
> # CONFIG_BLK_DEV_CS5520 is not set
> # CONFIG_BLK_DEV_HPT34X is not set
> # CONFIG_BLK_DEV_HPT366 is not set
> # CONFIG_BLK_DEV_SC1200 is not set
> # CONFIG_BLK_DEV_PIIX is not set
> # CONFIG_BLK_DEV_NS87415 is not set
> # CONFIG_BLK_DEV_OPTI621 is not set
> # CONFIG_BLK_DEV_PDC202XX_OLD is not set
> # CONFIG_BLK_DEV_PDC202XX_NEW is not set
> # CONFIG_BLK_DEV_RZ1000 is not set
> # CONFIG_BLK_DEV_SVWKS is not set
> # CONFIG_BLK_DEV_SIIMAGE is not set
> # CONFIG_BLK_DEV_SIS5513 is not set
> # CONFIG_BLK_DEV_SLC90E66 is not set
> # CONFIG_BLK_DEV_TRM290 is not set
> # CONFIG_BLK_DEV_VIA82CXXX is not set
> # CONFIG_IDEDMA_IVB is not set

Could you try selecting your specific IDE chipset (or all), it doesn't 
look like PIO is getting along famously with various other bits. I also 
noticed TCQ, do you have any TCQ capable IDE devices?

	Zwane

