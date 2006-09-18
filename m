Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965568AbWIRIWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965568AbWIRIWG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 04:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965573AbWIRIWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 04:22:05 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:56451 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965569AbWIRIWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 04:22:02 -0400
Subject: Re: [-mm patch 2/3] AVR32 MTD: Unlock flash if necessary (try 2)
From: David Woodhouse <dwmw2@infradead.org>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060918102131.1e210276@cad-250-152.norway.atmel.com>
References: <20060915163102.73bf171d@cad-250-152.norway.atmel.com>
	 <20060915163554.4f326bf6@cad-250-152.norway.atmel.com>
	 <20060915163711.10d19763@cad-250-152.norway.atmel.com>
	 <1158334346.24527.94.camel@pmac.infradead.org>
	 <20060918101224.12508491@cad-250-152.norway.atmel.com>
	 <1158567260.24527.313.camel@pmac.infradead.org>
	 <20060918102131.1e210276@cad-250-152.norway.atmel.com>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 09:21:37 +0100
Message-Id: <1158567697.24527.314.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-18 at 10:21 +0200, Haavard Skinnemoen wrote:
> Fine with me. The stuff that depends on this (and that I care about)
> is definitely not 2.6.18 material. There could of course be other
> boards where this matters, but they have to speak up for themselves. 

Largely, they have hacks in their own board drivers (or userspace) to
deal with the problem.

-- 
dwmw2

