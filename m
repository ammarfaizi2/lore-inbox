Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265383AbTFFHhi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 03:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265384AbTFFHhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 03:37:38 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:60423 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265383AbTFFHhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 03:37:37 -0400
Date: Fri, 6 Jun 2003 08:51:06 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, manfred@colorfullife.com,
       axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: problem with blk_queue_bounce_limit()
Message-ID: <20030606085106.A15894@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"David S. Miller" <davem@redhat.com>, davidm@hpl.hp.com,
	davidm@napali.hpl.hp.com, manfred@colorfullife.com, axboe@suse.de,
	linux-kernel@vger.kernel.org
References: <16096.16492.286361.509747@napali.hpl.hp.com> <20030606.003230.15263591.davem@redhat.com> <20030606084410.A14779@infradead.org> <20030606.004305.68041319.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030606.004305.68041319.davem@redhat.com>; from davem@redhat.com on Fri, Jun 06, 2003 at 12:43:05AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 06, 2003 at 12:43:05AM -0700, David S. Miller wrote:
>    From: Christoph Hellwig <hch@infradead.org>
>    Date: Fri, 6 Jun 2003 08:44:10 +0100
> 
>    PCI_DMA_BUS_IS_PHYS should be a propert of each struct device because
>    a machine might have a iommu for one bus type but not another,
> 
> We know of no such systems.  Even in mixed-bus environments such as
> sparc64 SBUS+PCI systems.

What about alpha systems with EISA and PCI slots?
