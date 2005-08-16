Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965122AbVHPGEC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965122AbVHPGEC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 02:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965124AbVHPGEC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 02:04:02 -0400
Received: from apate.telenet-ops.be ([195.130.132.57]:49613 "EHLO
	apate.telenet-ops.be") by vger.kernel.org with ESMTP
	id S965122AbVHPGEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 02:04:00 -0400
Date: Tue, 16 Aug 2005 08:03:46 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
Cc: Naveen Gupta <ngupta@google.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [-mm PATCH] set enable bit instead of lock bit of Watchdog Timer in Intel 6300 chipset
Message-ID: <20050816060346.GO499@infomag.infomag.iguana.be>
References: <Pine.LNX.4.56.0508151416530.27145@krishna.corp.google.com> <20050815222701.GB18872@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050815222701.GB18872@hardeman.nu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

> >This patch sets the WDT_ENABLE bit of the Lock Register to enable the
> >watchdog and WDT_LOCK bit only if nowayout is set. The old code always
> >sets the WDT_LOCK bit of watchdog timer for Intel 6300ESB chipset. So, we
> >end up locking the watchdog instead of enabling it.
> >
> >Signed-off-by: Naveen Gupta <ngupta@google.com>
> 
> Acked-by: David Härdeman <david@2gen.com>

I'm setting up the watchdog git trees at the moment (and doing the convertion
from the old bitkeeper repositories) when that's completed I will add these
new patches to the watchdog-tree.
I'll keep you posted.

Greetings,
Wim.

