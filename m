Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263125AbTJTX7f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 19:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263155AbTJTX7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 19:59:35 -0400
Received: from mail5.intermedia.net ([206.40.48.155]:16645 "EHLO
	mail5.intermedia.net") by vger.kernel.org with ESMTP
	id S263125AbTJTX7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 19:59:14 -0400
Subject: [BUG] sleep in invalid context #2
From: Ranjeet Shetye <ranjeet.shetye2@zultys.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Zultys Technologies Inc.
Message-Id: <1066694629.3916.3.camel@ranjeet-pc2.zultys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 20 Oct 2003 17:03:49 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Debug: sleeping function called from invalid context at mm/slab.c:1857
in_atomic():1, irqs_disabled():0
Call Trace:
 [<c011da5f>] __might_sleep+0xa0/0xc1
 [<c014081f>] kmem_cache_alloc+0x1cf/0x1d4
 [<c012068a>] printk+0x11d/0x17b
 [<c0105000>] _stext+0x0/0x61
 [<c013f134>] kmem_cache_create+0x16b/0x670
 [<c073e4d7>] mem_init+0x1aa/0x201
 [<c0105000>] _stext+0x0/0x61
 [<c074060e>] kmem_cache_init+0x117/0x2b2
 [<c073265e>] start_kernel+0xf1/0x1af
 [<c073243f>] unknown_bootoption+0x0/0xfa


-- 

Ranjeet Shetye
Senior Software Engineer
Zultys Technologies
Ranjeet dot Shetye2 at Zultys dot com
http://www.zultys.com/
 
The views, opinions, and judgements expressed in this message are solely
those of the author. The message contents have not been reviewed or
approved by Zultys.


