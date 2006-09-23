Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751517AbWIWUDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbWIWUDV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 16:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbWIWUDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 16:03:20 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:24271
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751517AbWIWUDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 16:03:19 -0400
Date: Sat, 23 Sep 2006 13:03:22 -0700 (PDT)
Message-Id: <20060923.130322.78711694.davem@davemloft.net>
To: auke-jan.h.kok@intel.com
Cc: akpm@osdl.org, Holger.Kiehl@dwd.de, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, netdev@vger.kernel.org,
       john.ronciak@intel.com
Subject: Re: 2.6.1[78] page allocation failure. order:3, mode:0x20
From: David Miller <davem@davemloft.net>
In-Reply-To: <451581FA.5080403@intel.com>
References: <20060922.222507.74751476.davem@davemloft.net>
	<20060922223348.1b24fda5.akpm@osdl.org>
	<451581FA.5080403@intel.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Auke Kok <auke-jan.h.kok@intel.com>
Date: Sat, 23 Sep 2006 11:50:34 -0700

> Andrew Morton wrote:
> > It's still there, isn't it?
> > 
> > For the 9k MTU case, for example, we end up allocating 16384 byte skbs
> > instead of 32786 kbytes ones.
> 
> yes, the only thing I'm doing is accounting for the 2 bytes one steap earlier. 

Ok, I'm fine with this patch unless it causes some regression that hasn't
been discovered yet :-)
