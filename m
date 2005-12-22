Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965044AbVLVCuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965044AbVLVCuk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 21:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965043AbVLVCuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 21:50:40 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:35784
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965007AbVLVCuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 21:50:39 -0500
Date: Wed, 21 Dec 2005 18:50:30 -0800 (PST)
Message-Id: <20051221.185030.131647618.davem@davemloft.net>
To: bunk@stusta.de
Cc: meyer@work.de, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com, netdev@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/sungem.c: gem_remove_one mustn't be
 __devexit
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051221132543.GG5359@stusta.de>
References: <200512211323.19242.meyer@work.de>
	<20051221132543.GG5359@stusta.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Wed, 21 Dec 2005 14:25:43 +0100

> gem_remove_one() is called from the __devinit gem_init_one().
> 
> Therefore, gem_remove_one() mustn't be __devexit.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Looks good, applied, thanks Adrian.
