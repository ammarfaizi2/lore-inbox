Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751014AbVHVUU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbVHVUU5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 16:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbVHVUU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 16:20:57 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:903
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751013AbVHVUU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 16:20:56 -0400
Date: Mon, 22 Aug 2005 13:20:52 -0700 (PDT)
Message-Id: <20050822.132052.65406121.davem@davemloft.net>
To: tony.luck@intel.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, jasonuhl@sgi.com
Subject: Re: CONFIG_PRINTK_TIME woes
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200508221742.j7MHgMJI020020@agluck-lia64.sc.intel.com>
References: <20050821021322.3986dd4a.akpm@osdl.org>
	<20050821021616.6bbf2a14.akpm@osdl.org>
	<200508221742.j7MHgMJI020020@agluck-lia64.sc.intel.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: tony.luck@intel.com
Date: Mon, 22 Aug 2005 10:42:22 -0700

> At the other extreme ... the current use of sched_clock() with
> potentially nano-second resolution is way over the top.

Not really, when I'm debugging TCP events over gigabit
these timestamps are exceptionally handy.
