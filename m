Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265379AbTFFHdQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 03:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265380AbTFFHdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 03:33:16 -0400
Received: from pizda.ninka.net ([216.101.162.242]:10217 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S265379AbTFFHdP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 03:33:15 -0400
Date: Fri, 06 Jun 2003 00:43:05 -0700 (PDT)
Message-Id: <20030606.004305.68041319.davem@redhat.com>
To: hch@infradead.org
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, manfred@colorfullife.com,
       axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: problem with blk_queue_bounce_limit()
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030606084410.A14779@infradead.org>
References: <16096.16492.286361.509747@napali.hpl.hp.com>
	<20030606.003230.15263591.davem@redhat.com>
	<20030606084410.A14779@infradead.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Christoph Hellwig <hch@infradead.org>
   Date: Fri, 6 Jun 2003 08:44:10 +0100

   PCI_DMA_BUS_IS_PHYS should be a propert of each struct device because
   a machine might have a iommu for one bus type but not another,

We know of no such systems.  Even in mixed-bus environments such as
sparc64 SBUS+PCI systems.
