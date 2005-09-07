Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbVIGCtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbVIGCtA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 22:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbVIGCtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 22:49:00 -0400
Received: from mail.dvmed.net ([216.237.124.58]:2027 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750811AbVIGCs7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 22:48:59 -0400
Message-ID: <431E5514.2070003@pobox.com>
Date: Tue, 06 Sep 2005 22:48:52 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: akpm@osdl.org, pavel@ucw.cz, ipw2100-admin@linux.intel.com, pavel@suse.cz,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [patch 1/1] ipw2100: remove by-hand function entry/exit debugging
References: <200509062056.j86KuHcL031448@shell0.pdx.osdl.net>	<431E4799.7000502@pobox.com> <20050906.194111.130652562.davem@davemloft.net>
In-Reply-To: <20050906.194111.130652562.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> From: Jeff Garzik <jgarzik@pobox.com>
> Date: Tue, 06 Sep 2005 21:51:21 -0400
> 
> 
>>NAK.  Rationale: maintainer's choice.  Pavel doesn't get to choose
>>the debugger of choice for the driver maintainer.
> 
> 
> If it makes the driver unreadable and thus harder to maintain,
> I think such changes should seriously be considered.
> 
> Most of the DEBUG_INFO macro usage is fine, but those "enter"
> and "exit" ones are just pure noise and should be removed.

I find them useful in my own drivers; they are definitely not pure noise.

	Jeff


