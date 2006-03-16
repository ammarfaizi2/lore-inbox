Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWCPIRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWCPIRk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 03:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752240AbWCPIRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 03:17:39 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:32406
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1752238AbWCPIRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 03:17:39 -0500
Date: Thu, 16 Mar 2006 00:17:15 -0800 (PST)
Message-Id: <20060316.001715.87364289.davem@davemloft.net>
To: ioe-lkml@rameria.de
Cc: yoshfuji@linux-ipv6.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH] Nearly complete kzalloc cleanup for net/ipv6
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200603112136.43553.ioe-lkml@rameria.de>
References: <200603112136.43553.ioe-lkml@rameria.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Oeser <ioe-lkml@rameria.de>
Date: Sat, 11 Mar 2006 21:36:42 +0100

> Stupidly use kzalloc() instead of kmalloc()/memset() 
> everywhere where this is possible in net/ipv6/*.c . 
> 
> Signed-off-by: Ingo Oeser <ioe-lkml@rameria.de>

This patch also looks fine.

Applied, thanks Ingo.
