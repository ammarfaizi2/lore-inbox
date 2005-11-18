Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030596AbVKRJIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030596AbVKRJIQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 04:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030592AbVKRJIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 04:08:15 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:19902
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932623AbVKRJIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 04:08:14 -0500
Date: Fri, 18 Nov 2005 01:08:02 -0800 (PST)
Message-Id: <20051118.010802.67654592.davem@davemloft.net>
To: rmk+lkml@arm.linux.org.uk
Cc: bunk@stusta.de, saw@saw.sw.com.sg, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] remove drivers/net/eepro100.c
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051118090158.GA11621@flint.arm.linux.org.uk>
References: <20051118033302.GO11494@stusta.de>
	<20051118090158.GA11621@flint.arm.linux.org.uk>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+lkml@arm.linux.org.uk>
Date: Fri, 18 Nov 2005 09:01:59 +0000

> On Fri, Nov 18, 2005 at 04:33:02AM +0100, Adrian Bunk wrote:
> > This patch removes the obsolete drivers/net/eepro100.c driver.
> > 
> > Is there any reason why it should be kept?
> 
> Tt's the only driver which works correctly on ARM CPUs.  e100 is
> basically buggy.  This has been discussed here on lkml and more
> recently on linux-netdev.  If anyone has any further questions
> please read the archives of those two lists.

Yes, sadly this is still true and therefore the eepro100 driver
needs to stick around.
