Return-Path: <linux-kernel-owner+w=401wt.eu-S1751078AbWLLD5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbWLLD5j (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 22:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbWLLD5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 22:57:39 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:58316
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751078AbWLLD5i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 22:57:38 -0500
Date: Mon, 11 Dec 2006 19:57:37 -0800 (PST)
Message-Id: <20061211.195737.71090466.davem@davemloft.net>
To: dada1@cosmosbay.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Introduce jiffies_32 and related compare functions
From: David Miller <davem@davemloft.net>
In-Reply-To: <457E2642.2000103@cosmosbay.com>
References: <457DE27E.5000100@cosmosbay.com>
	<20061211.173100.74720551.davem@davemloft.net>
	<457E2642.2000103@cosmosbay.com>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <dada1@cosmosbay.com>
Date: Tue, 12 Dec 2006 04:47:14 +0100

> I doubt being able to extend the expiration of a dst above 2^32
> ticks (49 days if HZ=1000, 198 days if HZ=250) is worth the ram
> wastage.

And this doesn't apply for all jiffies uses because? :-)

That's the point I'm trying to make and get a discussion on.
