Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbWCOBG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWCOBG7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 20:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbWCOBG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 20:06:58 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:28555
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932137AbWCOBG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 20:06:57 -0500
Date: Tue, 14 Mar 2006 17:06:48 -0800 (PST)
Message-Id: <20060314.170648.23393069.davem@davemloft.net>
To: bunk@stusta.de
Cc: patrick@tykepenguin.com, linux-decnet-user@lists.sourceforge.net,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/decnet/dn_route.c: fix inconsequent NULL
 checking
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060310230233.GB21864@stusta.de>
References: <20060310230233.GB21864@stusta.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Sat, 11 Mar 2006 00:02:33 +0100

> The Coverity checker noted this inconsequent NULL checking in
> dnrt_drop().
> 
> Since all callers ensure that NULL isn't passed, we can simply remove 
> the check.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks Adrian.
