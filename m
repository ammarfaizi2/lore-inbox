Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVAaO0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVAaO0I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 09:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbVAaO0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 09:26:08 -0500
Received: from news.suse.de ([195.135.220.2]:52147 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261212AbVAaO0G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 09:26:06 -0500
To: Hannes Reinecke <hare@suse.de>
Cc: Pavel Machek <pavel@suse.cz>, Linux Kernel <linux-kernel@vger.kernel.org>,
       mjg59@srcf.ucam.org
Subject: Re: [PATCH] Resume from initramfs
References: <41FE24F5.5070906@suse.de> <20050131125110.GD6279@elf.ucw.cz>
	<41FE3C34.4000200@suse.de>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Are you mentally here at Pizza Hut??
Date: Mon, 31 Jan 2005 15:26:04 +0100
In-Reply-To: <41FE3C34.4000200@suse.de> (Hannes Reinecke's message of "Mon,
 31 Jan 2005 15:09:56 +0100")
Message-ID: <jehdkxhdz7.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hannes Reinecke <hare@suse.de> writes:

> --- linux-2.6.10/kernel/power/disk.c.orig	2005-01-31
>     13:54:17.000000000 +0100
> +++ linux-2.6.10/kernel/power/disk.c	2005-01-31 14:55:14.000000000 +0100
> @@ -9,6 +9,8 @@
>    *
>    */
>
> +#define DEBUG
> +
>   #include <linux/suspend.h>
>   #include <linux/syscalls.h>
>   #include <linux/reboot.h>
> --- linux-2.6.10/kernel/power/swsusp.c.orig	2005-01-31
>     13:54:17.000000000 +0100
> +++ linux-2.6.10/kernel/power/swsusp.c	2005-01-31 14:53:36.000000000 +0100
> @@ -36,6 +36,8 @@
>    * For TODOs,FIXMEs also look in Documentation/power/swsusp.txt
>    */
>
> +#define DEBUG
> +
>   #include <linux/module.h>
>   #include <linux/mm.h>
>   #include <linux/suspend.h>

Another leftovers?

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
