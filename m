Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030200AbWGFJ6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030200AbWGFJ6S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 05:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030201AbWGFJ6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 05:58:18 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:62107 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030200AbWGFJ6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 05:58:17 -0400
Subject: Re: AVR32 architecture patch against Linux 2.6.18-rc1 available
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060706021906.1af7ffa3.akpm@osdl.org>
References: <20060706105227.220565f8@cad-250-152.norway.atmel.com>
	 <20060706021906.1af7ffa3.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 06 Jul 2006 11:58:13 +0200
Message-Id: <1152179893.3084.26.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> - do you really need __udivdi3() and friends?  We struggle hard to avoid
>   the necessity on x86 and you should be able to leverage that advantage.
> 
> - What are these for?
> 
> 	+EXPORT_SYMBOL(register_dma_controller);
> 	+EXPORT_SYMBOL(find_dma_controller);
> 
> 	+EXPORT_SYMBOL(clk_get);
> 	+EXPORT_SYMBOL(clk_put);
> 	+EXPORT_SYMBOL(clk_enable);
> 	+EXPORT_SYMBOL(clk_disable);
> 	+EXPORT_SYMBOL(clk_get_rate);
> 	+EXPORT_SYMBOL(clk_round_rate);
> 	+EXPORT_SYMBOL(clk_set_rate);
> 	+EXPORT_SYMBOL(clk_set_parent);
> 	+EXPORT_SYMBOL(clk_get_parent);

probably wants to be _GPL exports anyway


