Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946254AbWKAA7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946254AbWKAA7r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 19:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946239AbWKAA7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 19:59:47 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:60585
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1945968AbWKAA7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 19:59:46 -0500
Date: Tue, 31 Oct 2006 16:59:46 -0800 (PST)
Message-Id: <20061031.165946.126763326.davem@davemloft.net>
To: bunk@stusta.de
Cc: per.liden@ericsson.com, jon.maloy@ericsson.com,
       allan.stephens@windriver.com, tipc-discussion@lists.sourceforge.net,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/tipc/port.c: fix NULL dereference
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061101004037.GZ27968@stusta.de>
References: <20061101004037.GZ27968@stusta.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Wed, 1 Nov 2006 01:40:37 +0100

> The correct order is: NULL check before dereference
> 
> Spotted by the Coverity checker.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks Adrian.
