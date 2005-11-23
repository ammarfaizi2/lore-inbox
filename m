Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932563AbVKWWCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbVKWWCj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbVKWWCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:02:39 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:65433
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932563AbVKWWCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:02:38 -0500
Date: Wed, 23 Nov 2005 14:02:40 -0800 (PST)
Message-Id: <20051123.140240.109592494.davem@davemloft.net>
To: arjan@infradead.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk,
       torvalds@osdl.org, ak@muc.de
Subject: Re: [NET]: Shut up warnings in net/core/flow.c
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1132781300.2795.74.camel@laptopd505.fenrus.org>
References: <1132737084.2795.20.camel@laptopd505.fenrus.org>
	<20051123.132440.71355611.davem@davemloft.net>
	<1132781300.2795.74.camel@laptopd505.fenrus.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjan van de Ven <arjan@infradead.org>
Date: Wed, 23 Nov 2005 22:28:19 +0100

> I'm no gcc expert but afaik this really needs unit-at-a-time. (someone
> who knows more about gcc please correct me if I'm wrong).

Yes, it has to parse the whole file before it can determine
entirely that the static function is indeed not referenced.
