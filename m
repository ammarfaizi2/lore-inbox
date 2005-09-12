Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbVILPXC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbVILPXC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 11:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbVILPXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 11:23:02 -0400
Received: from ns1.suse.de ([195.135.220.2]:23486 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932072AbVILPXA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 11:23:00 -0400
From: Andi Kleen <ak@suse.de>
To: "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [patch 2.6.13 6/6] x86_64: implement dma_sync_single_range_for_{cpu,device}
Date: Mon, 12 Sep 2005 17:22:49 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <09122005104851.31248@bilbo.tuxdriver.com>
In-Reply-To: <09122005104851.31248@bilbo.tuxdriver.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509121722.49649.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 September 2005 16:48, John W. Linville wrote:
> Implement dma_sync_single_range_for_{cpu,device} for x86_64. This
> makes use of swiotlb_sync_single_range_for_{cpu,device}.

I already have the simple patch that just used sync_single_range in my tree 
and it's scheduled to go to Linus ASAP. You can rebase on that later.

-Andi
