Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423396AbWBBJFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423396AbWBBJFG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 04:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423397AbWBBJFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 04:05:06 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:28878
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1423396AbWBBJFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 04:05:01 -0500
Date: Thu, 02 Feb 2006 01:04:57 -0800 (PST)
Message-Id: <20060202.010457.40152473.davem@davemloft.net>
To: herbert@gondor.apana.org.au
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [lock validator] inet6_destroy_sock(): soft-safe ->
 soft-unsafe lock dependency
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060202084824.GA17299@gondor.apana.org.au>
References: <20060201202610.GA13107@gondor.apana.org.au>
	<20060202074627.GA6805@elte.hu>
	<20060202084824.GA17299@gondor.apana.org.au>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 2 Feb 2006 19:48:24 +1100

> You might also want to look at multicast but I don't know of any good
> tests for that.

David Stevens at IBM might have some tests.

