Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbVHQVYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbVHQVYL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 17:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbVHQVYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 17:24:11 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:9653
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751267AbVHQVYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 17:24:10 -0400
Date: Wed, 17 Aug 2005 14:24:02 -0700 (PDT)
Message-Id: <20050817.142402.43344792.davem@davemloft.net>
To: tglx@linutronix.de
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [RFC] IPV4 long lasting timer function
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1124312341.23647.277.camel@tglx.tec.linutronix.de>
References: <1124312341.23647.277.camel@tglx.tec.linutronix.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 17 Aug 2005 22:59:01 +0200

> Shouldn't this be converted to a workqueue, which gets triggered by a
> timer instead of blocking the timer softirq and therefor the delivery of
> other timer functions that long ?

We could, and I'd be happy to apply such a patch if someone
writes it up.
