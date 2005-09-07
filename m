Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbVIGClb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbVIGClb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 22:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbVIGClb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 22:41:31 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:12729
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750706AbVIGCla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 22:41:30 -0400
Date: Tue, 06 Sep 2005 19:41:11 -0700 (PDT)
Message-Id: <20050906.194111.130652562.davem@davemloft.net>
To: jgarzik@pobox.com
Cc: akpm@osdl.org, pavel@ucw.cz, ipw2100-admin@linux.intel.com, pavel@suse.cz,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [patch 1/1] ipw2100: remove by-hand function entry/exit
 debugging
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <431E4799.7000502@pobox.com>
References: <200509062056.j86KuHcL031448@shell0.pdx.osdl.net>
	<431E4799.7000502@pobox.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Garzik <jgarzik@pobox.com>
Date: Tue, 06 Sep 2005 21:51:21 -0400

> NAK.  Rationale: maintainer's choice.  Pavel doesn't get to choose
> the debugger of choice for the driver maintainer.

If it makes the driver unreadable and thus harder to maintain,
I think such changes should seriously be considered.

Most of the DEBUG_INFO macro usage is fine, but those "enter"
and "exit" ones are just pure noise and should be removed.
