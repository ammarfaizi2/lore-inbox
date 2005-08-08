Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbVHHVn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbVHHVn7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 17:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbVHHVn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 17:43:59 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:39829
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932274AbVHHVn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 17:43:58 -0400
Date: Mon, 08 Aug 2005 14:43:47 -0700 (PDT)
Message-Id: <20050808.144347.78712074.davem@davemloft.net>
To: linville@tuxdriver.com
Cc: greg@kroah.com, torvalds@osdl.org, ralf@linux-mips.org,
       linux-kernel@vger.kernel.org, linville@redhat.com
Subject: Re: pci_update_resource() getting called on sparc64
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050808213842.GA9010@tuxdriver.com>
References: <20050808.123209.59463259.davem@davemloft.net>
	<20050808194249.GA6729@kroah.com>
	<20050808213842.GA9010@tuxdriver.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "John W. Linville" <linville@tuxdriver.com>
Date: Mon, 8 Aug 2005 17:38:43 -0400

> So, w/ Dave's patch for Sparc64 to use setup-res.c, does the patch
> stay?  Is there anything else I need to do?

The plan is to revert your patch for 2.6.13, and then put it
back in with my (invasive at this point in the 2.6.13 development
cycle) sparc64 patch on top.
