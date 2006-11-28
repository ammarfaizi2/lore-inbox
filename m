Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757365AbWK1WwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757365AbWK1WwX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 17:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757377AbWK1WwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 17:52:22 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:50326 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1757365AbWK1WwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 17:52:22 -0500
Subject: Re: [-mm patch] drivers/mtd/nand/rtc_from4.c: use lib/bitrev.c
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>
In-Reply-To: <20061128144907.a9f4bb21.akpm@osdl.org>
References: <20061114014125.dd315fff.akpm@osdl.org>
	 <20061122043811.GG5200@stusta.de>
	 <1164752376.14595.22.camel@pmac.infradead.org>
	 <20061128144907.a9f4bb21.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 28 Nov 2006 22:52:16 +0000
Message-Id: <1164754336.14595.29.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-28 at 14:49 -0800, Andrew Morton wrote:
> Won't compile - you don't have the bitrev library patches.

Hm, yeah -- I'd just come to that conclusion :)

> I'll take that as an ack and shall merge this once
> crc32-replace-bitreverse-by-bitrev32.patch is merged ;)

I assume the bitrev thing will be going in as soon as 2.6.19 is actually
released, so there's no point in me reverting it from the mtd tree?

-- 
dwmw2

