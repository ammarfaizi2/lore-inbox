Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030357AbWGHUdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030357AbWGHUdO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 16:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030356AbWGHUdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 16:33:14 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:37341
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030352AbWGHUdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 16:33:13 -0400
Date: Sat, 08 Jul 2006 13:32:57 -0700 (PDT)
Message-Id: <20060708.133257.04463157.davem@davemloft.net>
To: bunk@stusta.de
Cc: samuel@sortiz.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fix drivers/net/irda/ali-ircc.c:ali_ircc_init()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060708012800.GH26941@stusta.de>
References: <20060708012800.GH26941@stusta.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Sat, 8 Jul 2006 03:28:05 +0200

> The Coverity checker spotted, that from the changes from commit 
> 898b1d16f8230fb912a0c2248df685735c6ceda3 the
>        if (ret)
>                platform_driver_unregister(&ali_ircc_driver);
> was dead code.
> 
> This patch changes this function to what seems to have been the 
> intention.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks Adrian.
