Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbVI2Xpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbVI2Xpt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 19:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbVI2Xpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 19:45:49 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:60361
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750783AbVI2Xps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 19:45:48 -0400
Date: Thu, 29 Sep 2005 16:45:45 -0700 (PDT)
Message-Id: <20050929.164545.109612016.davem@davemloft.net>
To: ecashin@coraid.com
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH 2.6.14-rc2] aoe [1/3]: explicitly set minimum packet
 length to ETH_ZLEN
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <874q83tsk9.fsf@coraid.com>
References: <87wtkzbz5z.fsf@coraid.com>
	<1128032491.9290.1.camel@localhost.localdomain>
	<874q83tsk9.fsf@coraid.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ed L Cashin <ecashin@coraid.com>
Date: Thu, 29 Sep 2005 18:31:02 -0400

> We suspect that the e1000 driver is misbehaving when given short
> packets, but we have not had time to pinpoint what part of the e1000
> driver is involved or what the specific problem is.

Then the e1000 driver is where the fix belongs, not the
aoe driver.
