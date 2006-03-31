Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbWCaHVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbWCaHVR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 02:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWCaHVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 02:21:17 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:16604
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751235AbWCaHVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 02:21:17 -0500
Date: Thu, 30 Mar 2006 23:21:39 -0800 (PST)
Message-Id: <20060330.232139.95365510.davem@davemloft.net>
To: kyle@parisc-linux.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] No arch-specific strpbrk implementations
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060331043327.GG31321@quicksilver.road.mcmartin.ca>
References: <20060331043327.GG31321@quicksilver.road.mcmartin.ca>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kyle McMartin <kyle@parisc-linux.org>
Date: Thu, 30 Mar 2006 23:33:27 -0500

> I think this is wrong, since no architecture currently defines
> __HAVE_ARCH_STRPBRK, there's no reason for any of them to be exporting
> it themselves. Therefore, consolidate the export to lib/string.c.

I noticed this too the other day, and I totally agree.

Thanks for taking care of this.
