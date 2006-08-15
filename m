Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWHOW5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWHOW5M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 18:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWHOW5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 18:57:12 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:28604
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750797AbWHOW5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 18:57:10 -0400
Date: Tue, 15 Aug 2006 15:56:12 -0700 (PDT)
Message-Id: <20060815.155612.111203542.davem@davemloft.net>
To: shemminger@osdl.org
Cc: mitch.a.williams@intel.com, notting@redhat.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: bonding: cannot remove certain named devices
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060815154444.286e12ed@localhost.localdomain>
References: <20060815214914.GA5307@nostromo.devel.redhat.com>
	<Pine.CYG.4.58.0608151532070.2316@mawilli1-desk2.amr.corp.intel.com>
	<20060815154444.286e12ed@localhost.localdomain>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Hemminger <shemminger@osdl.org>
Date: Tue, 15 Aug 2006 15:44:44 -0700

> IMHO idiots who put space's in filenames should be ignored. As long
> as the bonding code doesn't throw a fatal error, it has every right
> to return "No such device" to the fool.

I agree that whitespace in device names push the limits of sanity.

But if we believe that, we should enforce it in dev_valid_name().

Does anyone really mind if I add the whitespace check there?
