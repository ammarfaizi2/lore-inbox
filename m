Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317602AbSHCSqM>; Sat, 3 Aug 2002 14:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317639AbSHCSqM>; Sat, 3 Aug 2002 14:46:12 -0400
Received: from ool-182d14cd.dyn.optonline.net ([24.45.20.205]:516 "HELO
	osinvestor.com") by vger.kernel.org with SMTP id <S317602AbSHCSqL>;
	Sat, 3 Aug 2002 14:46:11 -0400
Date: Sat, 3 Aug 2002 13:49:57 -0400
From: Rob Radez <rob@osinvestor.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 10: 2.5.29-wdt977
Message-ID: <20020803134957.A13767@osinvestor.com>
References: <E17b3Rq-0006wh-00@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E17b3Rq-0006wh-00@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sat, Aug 03, 2002 at 07:16:18PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 03, 2002 at 07:16:18PM +0100, Russell King wrote:
> diff -urN orig/drivers/char/wdt977.c linux/drivers/char/wdt977.c
> --- orig/drivers/char/wdt977.c	Sat May 25 23:13:25 2002
> +++ linux/drivers/char/wdt977.c	Wed Jun 12 14:13:47 2002
> @@ -39,7 +39,7 @@
>  
>  static	int timeout = DEFAULT_TIMEOUT*60;	/* TO in seconds from user */
>  static	int timeoutM = DEFAULT_TIMEOUT;		/* timeout in minutes */
> -static	int timer_alive;
> +static	unsigned long timer_alive;
>  static	int testmode;
>  
>  MODULE_PARM(timeout, "i");

Not sure how much people will care, but this (and other funtastic) changes
are in my set of watchdog patches that I'll be making a big push to get
applied soon.  I haven't updated them to 2.4.19 or 2.5.30 yet but I'm hoping
to soon.  When I do, they'll be up at http://osinvestor.com/wd/ .

Regards,
Rob Radez
