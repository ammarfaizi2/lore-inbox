Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWIUAKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWIUAKu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 20:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWIUAKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 20:10:50 -0400
Received: from dvhart.com ([64.146.134.43]:31207 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1750722AbWIUAKt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 20:10:49 -0400
Message-ID: <4511D855.7050100@mbligh.org>
Date: Wed, 20 Sep 2006 17:09:57 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 -mm merge plans
References: <20060920135438.d7dd362b.akpm@osdl.org>
In-Reply-To: <20060920135438.d7dd362b.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> introduce-config_zone_dma.patch
> optional-zone_dma-in-the-vm.patch
> optional-zone_dma-in-the-vm-tidy.patch
> optional-zone_dma-for-i386.patch
> optional-zone_dma-for-x86_64.patch
> optional-zone_dma-for-ia64.patch
> remove-zone_dma-remains-from-parisc.patch
> remove-zone_dma-remains-from-sh-sh64.patch

Would it not make sense to define what ZONE_DMA actually means
consistently before trying to change it? The current mess across
different architectures seems like a disaster area to me.

What DOES requesting ZONE_DMA from a driver actually mean?

M.
