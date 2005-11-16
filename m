Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751498AbVKPTSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbVKPTSo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 14:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbVKPTSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 14:18:44 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:37010
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751498AbVKPTSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 14:18:44 -0500
Date: Wed, 16 Nov 2005 11:18:43 -0800 (PST)
Message-Id: <20051116.111843.23450955.davem@davemloft.net>
To: Markus.Lidel@shadowconnect.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] I2O: SPARC fixes
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <437B254E.9040909@shadowconnect.com>
References: <4379AADD.5000600@shadowconnect.com>
	<20051115.132836.41612515.davem@davemloft.net>
	<437B254E.9040909@shadowconnect.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Lidel <Markus.Lidel@shadowconnect.com>
Date: Wed, 16 Nov 2005 13:25:50 +0100

> > This should be detected at runtime, and that is easily done.
> > You can use the PCI device to get at the firmware device
> > node, and use that to look for a firmware device node property
> > that identifies it as a card from Sun.
> > Usually the "name" property has some identifying string in it.
> > Sometimes there is a property with the string "fcode" in it and you
> > could look for that as well.
> 
> OK, i'll look at it... Thanks for the hint!

Actually, my idea won't work if the card is used in a non-Sparc
system.  Do these cards have PCI subsystem vendor or device ID's that
identify it as a Sun card?
