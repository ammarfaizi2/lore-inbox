Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbVHWRaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbVHWRaN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 13:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbVHWRaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 13:30:13 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:10958
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932238AbVHWRaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 13:30:11 -0400
Date: Tue, 23 Aug 2005 10:30:10 -0700 (PDT)
Message-Id: <20050823.103010.51024114.davem@davemloft.net>
To: arjan@infradead.org
Cc: tedu@coverity.com, linux-kernel@vger.kernel.org, ralf@linux-mips.org
Subject: Re: some missing spin_unlocks
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1124816044.3218.18.camel@laptopd505.fenrus.org>
References: <430A5127.5000304@coverity.com>
	<20050823.094603.29591786.davem@davemloft.net>
	<1124816044.3218.18.camel@laptopd505.fenrus.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjan van de Ven <arjan@infradead.org>
Date: Tue, 23 Aug 2005 18:54:03 +0200

> does it matter? can ANYTHING be spinning on the lock? if not .. can we
> just let the lock go poof and not unlock it... 

I believe socket lookup can, otherwise the code is OK as-is.
