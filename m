Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268949AbTBSRTy>; Wed, 19 Feb 2003 12:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268950AbTBSRTx>; Wed, 19 Feb 2003 12:19:53 -0500
Received: from ip64-48-93-2.z93-48-64.customer.algx.net ([64.48.93.2]:40675
	"EHLO ns1.limegroup.com") by vger.kernel.org with ESMTP
	id <S268949AbTBSRTw>; Wed, 19 Feb 2003 12:19:52 -0500
Date: Wed, 19 Feb 2003 12:28:38 -0500 (EST)
From: Ion Badulescu <ionut@badula.org>
X-X-Sender: ion@guppy.limebrokerage.com
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: torvalds@transmeta.com, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] add new DMA_ADDR_T_SIZE define
In-Reply-To: <20030219092046.458c2876.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.44.0302191225510.29393-100000@guppy.limebrokerage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2003, Randy.Dunlap wrote:

> Does this help with being able to printk() a <dma_addr_t>?  How?
> Always use a cast to (u64) or something else?

It doesn't help with printk(), but frankly if you're printing a dma_addr_t 
then you're probably debugging, not performance-tuning, so the cast to u64 
is acceptable.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

