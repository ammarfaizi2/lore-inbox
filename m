Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263119AbUKTQfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263119AbUKTQfN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 11:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbUKTQcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 11:32:46 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:49928 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263080AbUKTQcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 11:32:21 -0500
Date: Sat, 20 Nov 2004 16:32:20 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk
Subject: Re: [5/7] Xen VMM patch set : split free_irq into teardown_irq
Message-ID: <20041120163220.GC19099@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ian Pratt <Ian.Pratt@cl.cam.ac.uk>, linux-kernel@vger.kernel.org,
	Steven.Hand@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk,
	Keir.Fraser@cl.cam.ac.uk
References: <E1CVHzW-0004XC-00@mta1.cl.cam.ac.uk> <E1CVI6L-0004bz-00@mta1.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CVI6L-0004bz-00@mta1.cl.cam.ac.uk>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +/*
> + * Internal function to unregister an irqaction - typically used to
> + * deallocate special interrupts that are part of the architecture.
>   */

It's not static so the internal is kinda wrong.  Please provide a full
kerneldoc comment, like the other functions in this file.

