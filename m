Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265358AbTFFGlV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 02:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265359AbTFFGlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 02:41:21 -0400
Received: from palrel13.hp.com ([156.153.255.238]:42456 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S265358AbTFFGlS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 02:41:18 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16096.15034.490916.644970@napali.hpl.hp.com>
Date: Thu, 5 Jun 2003 23:54:50 -0700
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, manfred@colorfullife.com, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: problem with blk_queue_bounce_limit()
In-Reply-To: <20030605.234526.23012957.davem@redhat.com>
References: <16094.58952.941468.221985@napali.hpl.hp.com>
	<1054797653.18294.1.camel@rth.ninka.net>
	<16096.14281.621282.67906@napali.hpl.hp.com>
	<20030605.234526.23012957.davem@redhat.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 05 Jun 2003 23:45:26 -0700 (PDT), "David S. Miller" <davem@redhat.com> said:

  >> From: David Mosberger <davidm@napali.hpl.hp.com>
  >> Date: Thu, 5 Jun 2003 23:42:17 -0700

  >> Manfred, I'm readdressed this mail to you because according to google,
  >> you're the original author of the patch
  >> (http://www.cs.helsinki.fi/linux/linux-kernel/2002-02/0032.html).

  >> Like I stated earlier, I think this code simply makes no sense on a
  >> platform with I/O MMU.  Hence my suggestion to deal with this via
  >> dma_supported().

  > David, what is blk_max_low_pfn set to on your ia64 systems?

max_low_pfn, which is going to be the pfn of some page > 4GB (for
machines with a sufficient amount of memory).

	--david
