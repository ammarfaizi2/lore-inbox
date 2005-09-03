Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbVICSUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbVICSUG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 14:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbVICSUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 14:20:06 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:36526
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751151AbVICSUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 14:20:05 -0400
Date: Sat, 03 Sep 2005 10:37:36 -0700 (PDT)
Message-Id: <20050903.103736.56666999.davem@davemloft.net>
To: len.brown@intel.com
Cc: reuben-lkml@reub.net, pwil3058@bigpond.net.au, akpm@osdl.org,
       linux-kernel@vger.kernel.org, James.Bottomley@steeleye.com,
       linux-scsi@vger.kernel.org
Subject: Re: 2.6.13-mm1 login fails
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30047FA093@hdsmsx401.amr.corp.intel.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B30047FA093@hdsmsx401.amr.corp.intel.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Brown, Len" <len.brown@intel.com>
Date: Sat, 3 Sep 2005 12:58:15 -0400

> CONFIG_AUDIT=y indeed did the trick.
> 
> When will I be able to delete CONFIG_AUDIT from my kernel again?

It's a regression we accidently added to the netlink socket
family, we will fix it.  But please use the workaround of
enabling CONFIG_AUDIT until we fix it, thanks.
