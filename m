Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbVHVVNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbVHVVNk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 17:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbVHVVNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 17:13:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38379 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751132AbVHVVNj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 17:13:39 -0400
Date: Mon, 22 Aug 2005 14:15:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: jasonuhl@sgi.com, tony.luck@intel.com, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PRINTK_TIME woes
Message-Id: <20050822141555.55276f3a.akpm@osdl.org>
In-Reply-To: <20050822.134226.35468933.davem@davemloft.net>
References: <200508221742.j7MHgMJI020020@agluck-lia64.sc.intel.com>
	<20050822.132052.65406121.davem@davemloft.net>
	<20050822203306.GA897956@dragonfly.engr.sgi.com>
	<20050822.134226.35468933.davem@davemloft.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@davemloft.net> wrote:
>
> I really do need sub-microsecond timings when I put a lot of
> printk tracing into the stack.

How fast is printk?  I haven't looked.

ie: if you do back-to-back printk's, what's the timestamp increment?
