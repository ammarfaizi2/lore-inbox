Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbULHKkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbULHKkz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 05:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbULHKkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 05:40:55 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:47519 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261178AbULHKkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 05:40:52 -0500
Date: Wed, 8 Dec 2004 11:40:50 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] include/asm-ppc/dma-mapping.h macro patch
In-Reply-To: <20041207150332.GA16936@infradead.org>
Message-ID: <Pine.LNX.4.53.0412081140070.20725@yvahk01.tjqt.qr>
References: <20041207132031.GA23542@jmcmullan.timesys> <20041207150332.GA16936@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> +#define dma_cache_inv(_start,_size)		do { (void)(_start); (void)(_size); } while (0)
>
>this looks really horrible.  What about turning these into inlines?

M I wonder why someone would cast the result to (void) anyway.


Jan Engelhardt
-- 
ENOSPC
