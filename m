Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbTD2MsL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 08:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbTD2MsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 08:48:11 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:33802 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261872AbTD2MsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 08:48:09 -0400
Date: Tue, 29 Apr 2003 16:59:47 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Christoph Hellwig <hch@infradead.org>, Marc Zyngier <mzyngier@freesurf.fr>,
       rth@twiddle.net, linux-kernel@vger.kernel.org
Subject: Re: [Patch] DMA mapping API for Alpha
Message-ID: <20030429165947.C5767@jurassic.park.msu.ru>
References: <wrp65oycvrw.fsf@hina.wild-wind.fr.eu.org> <20030429150532.A3984@jurassic.park.msu.ru> <20030429122014.A27520@infradead.org> <20030429160824.A5767@jurassic.park.msu.ru> <20030429133202.A29182@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030429133202.A29182@infradead.org>; from hch@infradead.org on Tue, Apr 29, 2003 at 01:32:03PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 29, 2003 at 01:32:03PM +0100, Christoph Hellwig wrote:
> Btw, did you read my posting from Friday on this issue?  The subjects is
> '[HEADS UP] planned change to <asm-generic/dma-mapping.h> will cause
> +arch breakage'

I did. But actual breakage would start if the drivers start to
use dma_* stuff with arbitrary bus types, USB for example.

Ivan.
