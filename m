Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLPBdJ>; Fri, 15 Dec 2000 20:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130686AbQLPBc7>; Fri, 15 Dec 2000 20:32:59 -0500
Received: from mx1.sac.fedex.com ([199.81.208.10]:4616 "EHLO mx1.sac.fedex.com")
	by vger.kernel.org with ESMTP id <S129183AbQLPBcv>;
	Fri, 15 Dec 2000 20:32:51 -0500
Date: Sat, 16 Dec 2000 08:58:55 +0800
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
Message-Id: <200012160058.eBG0wtr29000@silk.corp.fedex.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: Test12 ll_rw_block error.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Now, I also agree that we should be able to clean this up properly for
> 2.5.x, and actually do exactly this for the anonymous buffers, so that
> the VM no longer needs to worry about buffer knowledge, and fs/buffer.c
> becomes just another user of the writepage functionality.  That is not
> all that hard to do, it mainly just requires some small changes to how

Why not incorporate this change into 2.4.x?

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
