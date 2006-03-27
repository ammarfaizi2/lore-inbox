Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751535AbWC0Bj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbWC0Bj1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 20:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbWC0Bj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 20:39:27 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:4498
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751485AbWC0Bj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 20:39:26 -0500
Date: Sun, 26 Mar 2006 17:39:18 -0800 (PST)
Message-Id: <20060326.173918.15234485.davem@davemloft.net>
To: bunk@stusta.de
Cc: akpm@osdl.org, nkiesel@tbdnetworks.com, acme@conectiva.com.br,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [2.6 patch] net: drop duplicate assignment in request_sock
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060326122410.GG4053@stusta.de>
References: <20060326122410.GG4053@stusta.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Sun, 26 Mar 2006 14:24:10 +0200

> From: Norbert Kiesel <nkiesel@tbdnetworks.com>
> 
> Just noticed that request_sock.[ch] contain a useless assignment of
> rskq_accept_head to itself.  I assume this is a typo and the 2nd one
> was supposed to be _tail.  However, setting _tail to NULL is not
> needed, so the patch below just drops the 2nd assignment.
> 
> Signed-Off-By: Norbert Kiesel <nkiesel@tbdnetworks.com>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks.
