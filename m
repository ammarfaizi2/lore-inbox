Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262818AbTEGEMY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 00:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262820AbTEGEMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 00:12:24 -0400
Received: from ns.suse.de ([213.95.15.193]:18959 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262818AbTEGEMX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 00:12:23 -0400
Subject: Re: [PATCH][RFC] fixing the irqwcpustat mess
From: Andi Kleen <ak@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: davidm@mostang.com, linux-kernel@vger.kernel.org
In-Reply-To: <20030505212546.A24006@lst.de>
References: <20030505212546.A24006@lst.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 07 May 2003 06:24:54 +0200
Message-Id: <1052281495.18422.48.camel@averell>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-05 at 21:25, Christoph Hellwig wrote:

>  
> +#ifndef __ARCH_IRQ_STAT
>  irq_cpustat_t irq_stat[NR_CPUS] ____cacheline_aligned;
> +EXPORT_SYMBOL(irq_stat);
> +#endif

Shouldn't this be per_cpu_data ?

-Andi

