Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262942AbVGHWdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbVGHWdR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 18:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbVGHWbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 18:31:05 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:54417 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S262925AbVGHW3d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 18:29:33 -0400
Date: Sat, 9 Jul 2005 00:29:59 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Peter Osterlund <petero2@telia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix SERIO_RAW config help text
Message-ID: <20050708222959.GA3963@ucw.cz>
References: <m3ackxj6re.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3ackxj6re.fsf@telia.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 09, 2005 at 12:02:45AM +0200, Peter Osterlund wrote:
> Hi,
> 
> The help text for SERIO_RAW refers to the wrong sysfs device node.
> This patch fixes it.
> 
> Signed-off-by: Peter Osterlund <petero2@telia.com>
> ---

This patch is already in my queue, from Neil Brown.

>  linux-petero/drivers/input/serio/Kconfig |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN drivers/input/serio/Kconfig~serio-help-fix drivers/input/serio/Kconfig
> --- linux/drivers/input/serio/Kconfig~serio-help-fix	2005-07-05 11:43:25.000000000 +0200
> +++ linux-petero/drivers/input/serio/Kconfig	2005-07-05 11:43:25.000000000 +0200
> @@ -175,7 +175,7 @@ config SERIO_RAW
>  	  allocating minor 1 (that historically corresponds to /dev/psaux)
>  	  first. To bind this driver to a serio port use sysfs interface:
>  
> -	      echo -n "serio_raw" > /sys/bus/serio/devices/serioX/driver
> +	      echo -n "serio_raw" > /sys/bus/serio/devices/serioX/drvctl
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called serio_raw.
> _
> 
> -- 
> Peter Osterlund - petero2@telia.com
> http://web.telia.com/~u89404340
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
