Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbWCPIPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbWCPIPU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 03:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752235AbWCPIPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 03:15:20 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:29846
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751132AbWCPIPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 03:15:18 -0500
Date: Thu, 16 Mar 2006 00:14:59 -0800 (PST)
Message-Id: <20060316.001459.104988434.davem@davemloft.net>
To: ioe-lkml@rameria.de
Cc: yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IPv6: Cleanup of net/ipv6/reassambly.c
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200603120049.49294.ioe-lkml@rameria.de>
References: <200603120049.49294.ioe-lkml@rameria.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Oeser <ioe-lkml@rameria.de>
Date: Sun, 12 Mar 2006 00:49:48 +0100

> Two minor cleanups:
> 
> 1. Using kzalloc() in fraq_alloc_queue() 
>    saves the memset() in ipv6_frag_create().
> 
> 2. Invert sense of if-statements to streamline code.
>    Inverts the comment, too.
> 
> Signed-off-by: Ingo Oeser <ioe-lkml@rameria.de>

This patch looks great, applied.

Thanks a lot Ingo.
