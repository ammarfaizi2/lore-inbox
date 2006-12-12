Return-Path: <linux-kernel-owner+w=401wt.eu-S1750960AbWLLIAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbWLLIAj (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 03:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750961AbWLLIAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 03:00:39 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:41875
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750959AbWLLIAi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 03:00:38 -0500
Date: Tue, 12 Dec 2006 00:00:37 -0800 (PST)
Message-Id: <20061212.000037.93024784.davem@davemloft.net>
To: dada1@cosmosbay.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Introduce jiffies_32 and related compare functions
From: David Miller <davem@davemloft.net>
In-Reply-To: <457E52A3.6060503@cosmosbay.com>
References: <457E2B73.9040307@cosmosbay.com>
	<20061211.202735.104033567.davem@davemloft.net>
	<457E52A3.6060503@cosmosbay.com>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <dada1@cosmosbay.com>
Date: Tue, 12 Dec 2006 07:56:35 +0100

> But keeping 64bits values 'just because hardware allows us this kind of 
> expenditure' seems not reasonable to me, but lazy...

I agree with you for the most part.

Flexibility is pretty easy to maintain, and you seem to
alude to this, by allowing the jiffies_32 thing to have
a configurable type.

With this in mind maybe it's better to give the type some other more
descriptive name, something that states what the type represents,
rather than it's likely implementation :-)
