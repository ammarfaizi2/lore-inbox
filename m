Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270797AbTHAOtr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 10:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270803AbTHAOtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 10:49:47 -0400
Received: from wing.tritech.co.jp ([202.33.12.153]:17072 "HELO
	wing.tritech.co.jp") by vger.kernel.org with SMTP id S270797AbTHAOtq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 10:49:46 -0400
Date: Fri, 01 Aug 2003 23:49:44 +0900 (JST)
Message-Id: <20030801.234944.27784642.ooyama@tritech.co.jp>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: RAW or BLK in 2.4.21
From: ooyama eiichi <ooyama@tritech.co.jp>
In-Reply-To: <20030801102733.GO7920@suse.de>
References: <20030801.192419.68158364.ooyama@tritech.co.jp>
	<20030801102733.GO7920@suse.de>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Axboe.
hmm, it is that i have to look at the design again.

eiichi

> On Fri, Aug 01 2003, ooyama eiichi wrote:
> > Hi.
> > I am developping a block device kernel module in 2.4 series.
> > And i want to make a distinction between raw I/O and block I/O,
> > in the request function i wrote for my module.
> > But i could not find the way.
> > 
> > my_request_fn(request_queue_t *q, int rw, struct buffer_head * bh)
> > 
> > Is it possible ?
> > I would be happy if someone give me a hint about this.
> 
> No, it is not possible to tell the difference inside your request_fn.
> 
> -- 
> Jens Axboe
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
