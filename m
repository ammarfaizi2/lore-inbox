Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbVKUHcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbVKUHcn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 02:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbVKUHcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 02:32:43 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:12042 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751012AbVKUHcm (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 02:32:42 -0500
Date: Mon, 21 Nov 2005 08:33:58 +0100
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: [patch 2.6.15-rc2] blk: request poisoning
Message-ID: <20051121073357.GS25454@suse.de>
References: <438182E7.9080809@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438182E7.9080809@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21 2005, Nick Piggin wrote:
> This patch should make request poisoning more useful
> and more easily extendible in the block layer.
> 
> Don't think I have hardware that will trigger a requeue,
> but otherwise it has been moderately tested. Comments?

I like the idea, but I'm a little worried that it actually introduces
more problems than it solves. See the mail from yesterday for instance,
perfectly fine code but 'as' poisoning triggered.

And the merging bits already look really ugly :/

So I guess my question is, did this code ever find any driver problems?

-- 
Jens Axboe

