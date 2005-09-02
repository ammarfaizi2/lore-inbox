Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161075AbVIBV57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161075AbVIBV57 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 17:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161076AbVIBV57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 17:57:59 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:53405
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161075AbVIBV56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 17:57:58 -0400
Date: Fri, 02 Sep 2005 14:57:47 -0700 (PDT)
Message-Id: <20050902.145747.66384453.davem@davemloft.net>
To: nickpiggin@yahoo.com.au
Cc: ak@suse.de, alan@lxorguk.ukuu.org.uk, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.13] lockless pagecache 2/7
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <4318C884.3050607@yahoo.com.au>
References: <4318C28A.5010000@yahoo.com.au>
	<20050902.143149.08652495.davem@davemloft.net>
	<4318C884.3050607@yahoo.com.au>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Piggin <nickpiggin@yahoo.com.au>
Date: Sat, 03 Sep 2005 07:47:48 +1000

> So neither could currently supported atomic_t ops be shared with
> userland accesses?

Correct.

> Then I think it would not be breaking any interface rule to do an
> atomic_t atomic_cmpxchg either. Definitely for my usage it will
> not be shared with userland.

Ok.
