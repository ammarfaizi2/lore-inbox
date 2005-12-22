Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030196AbVLVPRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbVLVPRP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 10:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbVLVPRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 10:17:14 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:62668
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751092AbVLVPRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 10:17:14 -0500
Date: Thu, 22 Dec 2005 07:16:51 -0800 (PST)
Message-Id: <20051222.071651.43525556.davem@davemloft.net>
To: akpm@osdl.org
Cc: bunk@stusta.de, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       aabdulla@nvidia.com, jgarzik@pobox.com, netdev@vger.kernel.org,
       ak@suse.de, discuss@x86-64.org, perex@suse.cz,
       alsa-devel@alsa-project.org, gregkh@suse.de
Subject: Re: 2.6.15-rc6: known regressions in the kernel Bugzilla
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051222005209.0b1b25ca.akpm@osdl.org>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>
	<20051222011320.GL3917@stusta.de>
	<20051222005209.0b1b25ca.akpm@osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Thu, 22 Dec 2005 00:52:09 -0800

> From: Charles-Edouard Ruault <ce@ruault.com>
> Subject: [BUG] kernel 2.6.14.2 breaks IPSEC

Herbert's reply at the end of the thread explains that what the user
is doing, applying SNAT to IPSEC, has undefined results currently.

Using netfilter with IPSEC is known to be broken since the beginning
of our IPSEC implementation, and we plan to cure it in 2.6.16 with
some excellent work done by Patrick McHardy and Herbert Xu.

So just remove that from your list please, thanks.
