Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbWGRUaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbWGRUaI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 16:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbWGRUaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 16:30:08 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:49875
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932387AbWGRUaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 16:30:07 -0400
Date: Tue, 18 Jul 2006 13:30:27 -0700 (PDT)
Message-Id: <20060718.133027.102614767.davem@davemloft.net>
To: bunk@stusta.de
Cc: christopher.leech@intel.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [2.6 patch] net/core/user_dma.c should #include <net/netdma.h>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060715003617.GL3633@stusta.de>
References: <20060715003617.GL3633@stusta.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Sat, 15 Jul 2006 02:36:17 +0200

> Every file should #include the headers containing the prototypes for 
> its global functions.
> 
> Especially in cases like this one where gcc can tell us through a 
> compile error that the prototype was wrong...
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks Adrian.
