Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264493AbTFEHH3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 03:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264494AbTFEHH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 03:07:29 -0400
Received: from rth.ninka.net ([216.101.162.244]:50048 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S264493AbTFEHH2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 03:07:28 -0400
Subject: Re: problem with blk_queue_bounce_limit()
From: "David S. Miller" <davem@redhat.com>
To: davidm@hpl.hp.com
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <16094.58952.941468.221985@napali.hpl.hp.com>
References: <16094.58952.941468.221985@napali.hpl.hp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054797653.18294.1.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 Jun 2003 00:20:53 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-04 at 23:42, David Mosberger wrote:
> On platforms with I/O MMU hardware, memory above 4GB, and IDE hard disks,
> this check:
> 
> 		BUG_ON(dma_addr < BLK_BOUNCE_ISA);

Doesn't panic on sparc64, let this be your guiding light :-)

-- 
David S. Miller <davem@redhat.com>
