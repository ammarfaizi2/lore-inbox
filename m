Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933030AbWFWLBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933030AbWFWLBU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 07:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933017AbWFWLBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 07:01:20 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:65517
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S933004AbWFWLBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 07:01:18 -0400
Date: Fri, 23 Jun 2006 04:01:15 -0700 (PDT)
Message-Id: <20060623.040115.108744369.davem@davemloft.net>
To: bunk@stusta.de
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] make net/core/skbuff.c:skb_release_data() static
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060623105623.GT9111@stusta.de>
References: <20060623105623.GT9111@stusta.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Fri, 23 Jun 2006 12:56:23 +0200

> skb_release_data() no longer has any users in other files.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

If you are going to do this, you need to remove the reference
in arch/x86_64/kernel/functionlist too.

Thanks.
