Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936704AbWLCOQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936704AbWLCOQm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 09:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936706AbWLCOQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 09:16:42 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:56279 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S936703AbWLCOQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 09:16:41 -0500
Subject: Re: [PATCH 2.6.19 2/3] sata_promise: new EH conversion
From: Arjan van de Ven <arjan@infradead.org>
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Mikael Pettersson <mikpe@it.uu.se>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <4572CEE7.502@gmail.com>
References: <200612010958.kB19wGbg002454@alkaid.it.uu.se>
	 <4572CA7A.6010103@gmail.com> <4572CB2B.8050406@garzik.org>
	 <4572CEE7.502@gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 03 Dec 2006 15:16:07 +0100
Message-Id: <1165155367.3233.220.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> But, having those flushes won't hurt either.  What was the conclusion of
> mmio <-> spinlock sync discussion?  I always feel kind of uncomfortable
> about readl() flushes.  I think they're too subtle.

those are orthogonal!
The posting flushes have nothing to do with spinlock-vs-mmio; that
discussion was about the CPU, while posting flushes are about the
chipset / bridges / etc....

> 
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

