Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbWHNRZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbWHNRZw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 13:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932576AbWHNRZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 13:25:52 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:38584 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932478AbWHNRZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 13:25:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=osHDrNHRdbTa/GxaC7pgtnKj9/SSvxpGOQGLTC6tsLNI1Z88NSzR9qR/dJ6iVs+I4Et+6jsP4FrT6aNtwI2M2bWnNmMznz4ttWG0EE1j+cDWogvZHmhS9nTkdCy59qH0Bw2ZV8Tcbz8tUzAhuK7+cZZQtLrLUX0Boleq/CfsuZ4=
Date: Mon, 14 Aug 2006 19:25:58 +0200
From: Luca <kronos.it@gmail.com>
To: thomas@koeller.dyndns.org
Cc: linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
       linux-mips@linux-mips.org
Subject: Re: [PATCH] Added MIPS RM9K watchdog driver
Message-ID: <20060814172558.GA15951@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608102319.13679.thomas@koeller.dyndns.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thomas@koeller.dyndns.org ha scritto:
> diff --git a/drivers/char/watchdog/rm9k_wdt.c 
> b/drivers/char/watchdog/rm9k_wdt.c
> new file mode 100644
> index 0000000..f6a9d17
> --- /dev/null
> +++ b/drivers/char/watchdog/rm9k_wdt.c
> @@ -0,0 +1,435 @@
[...]
> +/* Module arguments */
> +static int timeout = MAX_TIMEOUT_SECONDS;
> +module_param(timeout, int, 444);
> +static unsigned long resetaddr = 0xbffdc200;
> +module_param(resetaddr, ulong, 444);
> +static unsigned long flagaddr = 0xbffdc104;
> +module_param(flagaddr, ulong, 444);
> +static int powercycle = 0;
> +module_param(powercycle, bool, 444);

File permissions should be in octal ;)

Luca
-- 
Home: http://kronoz.cjb.net
"New processes are created by other processes, just like new
 humans. New humans are created by other humans, of course,
 not by processes." -- Unix System Administration Handbook
