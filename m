Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbTD2GrH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 02:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbTD2GrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 02:47:07 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:30481 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261965AbTD2GrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 02:47:07 -0400
Date: Tue, 29 Apr 2003 07:59:19 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Marc Zyngier <mzyngier@freesurf.fr>
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, linux-kernel@vger.kernel.org
Subject: Re: [Patch] DMA mapping API for Alpha
Message-ID: <20030429075919.A22024@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Marc Zyngier <mzyngier@freesurf.fr>, rth@twiddle.net,
	ink@jurassic.park.msu.ru, linux-kernel@vger.kernel.org
References: <wrp65oycvrw.fsf@hina.wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <wrp65oycvrw.fsf@hina.wild-wind.fr.eu.org>; from mzyngier@freesurf.fr on Mon, Apr 28, 2003 at 08:38:27PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 28, 2003 at 08:38:27PM +0200, Marc Zyngier wrote:
> +
> +/* Shamelessly picked from arch/i386/kernel/pci-dma.c, as it should
> + * fit the Jensen quite well. The rest of the generic DMA API lives in
> + * asm-alpha/dma-mapping.h. */

Hmm, maybe we need to add a kernel/dump-dma-mapping.c at some point.. :)

Else the changes look really nice to me.
