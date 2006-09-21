Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750860AbWIUAkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbWIUAkU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 20:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbWIUAkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 20:40:20 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:25297 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750776AbWIUAkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 20:40:18 -0400
Subject: Re: ZONE_DMA (was: Re: 2.6.19 -mm merge plans)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Lameter <clameter@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@mbligh.org>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <Pine.LNX.4.64.0609201724490.2403@schroedinger.engr.sgi.com>
References: <20060920135438.d7dd362b.akpm@osdl.org>
	 <4511D855.7050100@mbligh.org> <20060920172253.f6d11445.akpm@osdl.org>
	 <Pine.LNX.4.64.0609201724490.2403@schroedinger.engr.sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 21 Sep 2006 02:03:50 +0100
Message-Id: <1158800630.11109.72.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-09-20 am 17:31 -0700, ysgrifennodd Christoph Lameter:
> ZONE_DMA does not have a bright future with IOMMUs and other things 
> around. None of my system uses ZONE_DMA and I have a variety of them.

IOMMUs don't always help. They IOMMU aperture on AMD64 for example is
too high to help devices with below 32bit limits.

