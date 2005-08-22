Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751438AbVHVWgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbVHVWgj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbVHVWgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:36:38 -0400
Received: from fmr24.intel.com ([143.183.121.16]:52440 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751472AbVHVWeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:34:21 -0400
Date: Mon, 22 Aug 2005 15:33:16 -0700
From: tony.luck@intel.com
Message-Id: <200508222233.j7MMXGWj020872@agluck-lia64.sc.intel.com>
To: Andrew Morton <akpm@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: jasonuhl@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PRINTK_TIME woes
In-Reply-To: <20050822141555.55276f3a.akpm@osdl.org>
References: <200508221742.j7MHgMJI020020@agluck-lia64.sc.intel.com>
	<20050822.132052.65406121.davem@davemloft.net>
	<20050822203306.GA897956@dragonfly.engr.sgi.com>
	<20050822.134226.35468933.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>How fast is printk?  I haven't looked.
>
>ie: if you do back-to-back printk's, what's the timestamp increment?

On ia64 it looks like about 4-5 usec increment for back-to-back
printk (with no serial console configured, and dmesg -n to turn
off messages to the VGA console).

-Tony
