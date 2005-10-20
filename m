Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932509AbVJTRw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbVJTRw2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 13:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbVJTRw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 13:52:28 -0400
Received: from gate.corvil.net ([213.94.219.177]:36614 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S932509AbVJTRw1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 13:52:27 -0400
Message-ID: <4357D941.4090705@draigBrady.com>
Date: Thu, 20 Oct 2005 18:52:01 +0100
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pozsar Balazs <pozsy@uhulinux.hu>
CC: linux-kernel@vger.kernel.org, wim@iguana.be
Subject: Re: [PATCH] fix typo drivers/char/watchdog/w83627hf_wdt.c
References: <20051020174202.GA30201@ojjektum.uhulinux.hu>
In-Reply-To: <20051020174202.GA30201@ojjektum.uhulinux.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pozsar Balazs wrote:
> The most trivial typo fix in the world.
> 
> Signed-off-by: Pozsar Balazs <pozsy@uhulinux.hu>
> 
> --- a/drivers/char/watchdog/w83627hf_wdt.c	2005-10-11 03:19:19.000000000 +0200
> +++ b/drivers/char/watchdog/w83627hf_wdt.c	2005-10-20 19:39:01.000000000 +0200
> @@ -359,5 +359,5 @@
>  
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Pdraig Brady <P@draigBrady.com>");
> -MODULE_DESCRIPTION("w38627hf WDT driver");
> +MODULE_DESCRIPTION("w83627hf WDT driver");
>  MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);

Oops :)

I notice also that my name has been
mangled someplace along the line to "Pdraig".
Ideally it's Pádraig but I'll settle for Padraig :)
Can you send the updated patch to Wim (cc'd),
for merging into the watchdog tree.

thanks,
Pádraig.
