Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030255AbWISQqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbWISQqA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 12:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030256AbWISQp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 12:45:59 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:25780 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030254AbWISQp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 12:45:58 -0400
Message-ID: <45101EC1.7040407@garzik.org>
Date: Tue, 19 Sep 2006 12:45:53 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@linux-mips.org>
CC: Amy Fong <amy.fong@windriver.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH] Add Broadcom PHY support
References: <E1GPflG-0000n7-2o@lucciola> <Pine.LNX.4.64N.0609191441260.24069@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0609191441260.24069@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki wrote:
> On Tue, 19 Sep 2006, Amy Fong wrote:
> 
>>> And... where are the users of this phy driver?
> [...]
>> This phy driver is used by the WRS's sbc8560 (bcm5421s) and sbc843x 
>> (bcm5461s) via the gianfar driver.
> 
>  And sb1250-mac.c would be happy to use it too.

"would be happy to" != "is using".   I don't want to add a phy driver 
until there are already active users in the kernel.

	Jeff



