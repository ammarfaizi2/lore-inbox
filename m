Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265349AbTFFGf1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 02:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265352AbTFFGf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 02:35:27 -0400
Received: from pizda.ninka.net ([216.101.162.242]:38376 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S265349AbTFFGf1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 02:35:27 -0400
Date: Thu, 05 Jun 2003 23:45:26 -0700 (PDT)
Message-Id: <20030605.234526.23012957.davem@redhat.com>
To: davidm@hpl.hp.com, davidm@napali.hpl.hp.com
Cc: manfred@colorfullife.com, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: problem with blk_queue_bounce_limit()
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <16096.14281.621282.67906@napali.hpl.hp.com>
References: <16094.58952.941468.221985@napali.hpl.hp.com>
	<1054797653.18294.1.camel@rth.ninka.net>
	<16096.14281.621282.67906@napali.hpl.hp.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@napali.hpl.hp.com>
   Date: Thu, 5 Jun 2003 23:42:17 -0700
   
   Manfred, I'm readdressed this mail to you because according to google,
   you're the original author of the patch
   (http://www.cs.helsinki.fi/linux/linux-kernel/2002-02/0032.html).
   
   Like I stated earlier, I think this code simply makes no sense on a
   platform with I/O MMU.  Hence my suggestion to deal with this via
   dma_supported().
   
David, what is blk_max_low_pfn set to on your ia64 systems?
