Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWHBS4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWHBS4m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 14:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWHBS4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 14:56:42 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:42201 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP id S932120AbWHBS4l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 14:56:41 -0400
Date: Wed, 2 Aug 2006 21:56:29 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use valid_dma_direction() in include/asm-i386/dma-mapping.h
Message-ID: <20060802185629.GC4982@rhun.ibm.com>
References: <200607280928.54306.eike-kernel@sf-tec.de> <20060728174449.GA11046@rhun.ibm.com> <200608021722.35797.eike-kernel@sf-tec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608021722.35797.eike-kernel@sf-tec.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2006 at 05:22:35PM +0200, Rolf Eike Beer wrote:

> Now that the generic DMA code has a function to decide if a given DMA
> mapping is valid use it. This will catch cases where direction is not any
> of the defined enum values but some random number outside the valid range.
> The current implementation will only catch the defined but invalid case
> DMA_NONE.
> 
> Signed-off-by: Rolf Eike Beer

Acked-by: Muli Ben-Yehuda <muli@il.ibm.com>

... but see my comments to your other patch this one depends on.

Cheers,
Muli
