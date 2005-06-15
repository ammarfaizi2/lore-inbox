Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbVFOTXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbVFOTXD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 15:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVFOTXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 15:23:03 -0400
Received: from mail.dif.dk ([193.138.115.101]:24783 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261466AbVFOTXA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 15:23:00 -0400
Date: Wed, 15 Jun 2005 21:28:23 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: "David S. Miller" <davem@davemloft.net>
Cc: juhl-lkml@dif.dk, yoshfuji@linux-ipv6.org, kuznet@ms2.inr.ac.ru,
       jmorris@redhat.com, waltje@uWalt.NL.Mugnet.ORG, ross.biro@gmail.com,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [-mm PATCH] signed vs unsigned cleanup in net/ipv4/raw.c
In-Reply-To: <20050615.121628.112622743.davem@davemloft.net>
Message-ID: <Pine.LNX.4.62.0506152127150.3842@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0506152101350.3842@dragon.hyggekrogen.localhost>
 <20050615.121628.112622743.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2005, David S. Miller wrote:

> 
> I'm not merging this thing, at least no all at once.
> 
> "size_t" vs. "unsigned int" vs. "int" length comparisons are where all
> the security problems come from in the protocol stack
> 
> Therefore you should make a seperate patch for each type
> change you make and explain why it doesn't add some regression
> in terms of signedness issues.
> 

Fair enough, I'll split it into little bits and submit them one by one 
with explanations. Not a problem at all.

-- 
Jesper Juhl


