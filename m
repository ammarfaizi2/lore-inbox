Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbWDBKlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWDBKlu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 06:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWDBKlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 06:41:49 -0400
Received: from host-84-9-202-129.bulldogdsl.com ([84.9.202.129]:28618 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S932303AbWDBKls
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 06:41:48 -0400
Date: Sun, 2 Apr 2006 11:41:34 +0100
From: Ben Dooks <ben-linux@fluff.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: rpurdie@rpsys.net, kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] fix LED help text
Message-ID: <20060402104134.GA4866@home.fluff.org>
References: <20060402103719.GA2475@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060402103719.GA2475@elf.ucw.cz>
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02, 2006 at 12:37:19PM +0200, Pavel Machek wrote:
> TRIGGER_IDE_DISK is not really timer-based LED.
> 
> Signed-off-by: Pavel Machek <pavel@suse.cz>
> 
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 2c4f20b..c02ef24 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -67,7 +67,7 @@ config LEDS_TRIGGER_TIMER
>  	  via sysfs. If unsure, say Y.
>  
>  config LEDS_TRIGGER_IDE_DISK
> -	bool "LED Timer Trigger"
> +	bool "LED IDE Disk Trigger"
>  	depends LEDS_TRIGGERS && BLK_DEV_IDEDISK
>  	help
>  	  This allows LEDs to be controlled by IDE disk activity.

spotted that one yesterday, and have sent patch to akpm
(which I belive he has already queued for -mm)

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
