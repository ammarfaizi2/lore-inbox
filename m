Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270703AbTHAK1i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 06:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270707AbTHAK1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 06:27:38 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:6830 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S270703AbTHAK1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 06:27:36 -0400
Date: Fri, 1 Aug 2003 12:27:33 +0200
From: Jens Axboe <axboe@suse.de>
To: ooyama eiichi <ooyama@tritech.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RAW or BLK in 2.4.21
Message-ID: <20030801102733.GO7920@suse.de>
References: <20030801.192419.68158364.ooyama@tritech.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030801.192419.68158364.ooyama@tritech.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 01 2003, ooyama eiichi wrote:
> Hi.
> I am developping a block device kernel module in 2.4 series.
> And i want to make a distinction between raw I/O and block I/O,
> in the request function i wrote for my module.
> But i could not find the way.
> 
> my_request_fn(request_queue_t *q, int rw, struct buffer_head * bh)
> 
> Is it possible ?
> I would be happy if someone give me a hint about this.

No, it is not possible to tell the difference inside your request_fn.

-- 
Jens Axboe

