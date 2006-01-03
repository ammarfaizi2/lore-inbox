Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbWACTdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbWACTdu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 14:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbWACTdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 14:33:50 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:44711 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932427AbWACTdt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 14:33:49 -0500
Date: Tue, 3 Jan 2006 20:33:40 +0100
From: VMiklos <vmiklos@frugalware.org>
To: LKML Mailinglist <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] add missing option in kconfig for ipw2200 monitor mode
Message-ID: <20060103193340.GX5849@genesis.frugalware.org>
References: <1131855414.16512.1.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131855414.16512.1.camel@localhost>
User-Agent: mutt-ng/devel-r655 (Frugalware Linux Distribution)
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.8 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 13, 2005 at 05:16:54AM +0100, Kasper Sandberg <lkml@metanurb.dk> wrote:
> This patch adds monitor mode option to ipw2200....
> 
> signed-off-by: Kasper Sandberg <lkml@metanurb.dk>

> diff -Naur linux-2.6.15-rc1-a/drivers/net/wireless/Kconfig linux-2.6.15-rc1-b/drivers/net/wireless/Kconfig
> --- linux-2.6.15-rc1-a/drivers/net/wireless/Kconfig	2005-11-13 05:11:39.451031050 +0100
> +++ linux-2.6.15-rc1-b/drivers/net/wireless/Kconfig	2005-11-13 05:12:36.834130145 +0100
> @@ -217,6 +217,15 @@
>            say M here and read <file:Documentation/modules.txt>.  The module
>            will be called ipw2200.ko.
>  
> +config IPW2200_MONITOR
> +        bool "Enable promiscuous mode"
> +        depends on IPW2200
> +        ---help---
> +          Enables promiscuous/monitor mode support for the ipw2200 driver.
> +          With this feature compiled into the driver, you can switch to
> +          promiscuous mode via the Wireless Tool's Monitor mode.  While in this
> +          mode, no packets can be sent.
> +
>  config IPW_DEBUG
>  	bool "Enable full debugging output in IPW2200 module."
>  	depends on IPW2200

Please comment and/or consider for inclusion.

udv / greetings,
VMiklos

-- 
Developer of Frugalware Linux, to make things frugal - http://frugalware.org
