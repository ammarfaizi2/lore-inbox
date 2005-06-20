Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbVFTVFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbVFTVFO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 17:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVFTU4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 16:56:11 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:6275
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262391AbVFTUnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 16:43:06 -0400
Date: Mon, 20 Jun 2005 13:43:02 -0700 (PDT)
Message-Id: <20050620.134302.85685273.davem@davemloft.net>
To: linux-os@analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.6.12 memory mapping broken
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.61.0506201548150.5317@chaos.analogic.com>
References: <Pine.LNX.4.61.0506201548150.5317@chaos.analogic.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Richard B. Johnson" <linux-os@analogic.com>
Date: Mon, 20 Jun 2005 15:53:34 -0400 (EDT)

> I can test any patches.

You have to let remap_pfn_range() fill in the PTEs for you,
you can't fill them in yourself.  Just supply the correct
"pfn" argument and you should be all set.
