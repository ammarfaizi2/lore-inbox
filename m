Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbVAHQYB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVAHQYB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 11:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbVAHQYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 11:24:01 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7089 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261205AbVAHQX5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 11:23:57 -0500
Message-ID: <41E0090D.30202@pobox.com>
Date: Sat, 08 Jan 2005 11:23:41 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Magnus Damm <damm@opensource.se>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ide: possible typo in ide-disk.c
References: <20050108160509.14026.98420.83109@kubu>
In-Reply-To: <20050108160509.14026.98420.83109@kubu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Magnus Damm wrote:
> Hello,
> 
> A search for "task_no_data_intr" tells me that this is probably a typo.
> 
> / magnus
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> 
> --- linux-2.6.10/drivers/ide/ide-disk.c	2004-12-24 22:34:32.000000000 +0100
> +++ linux-2.6.10-ide_task_no_data_intr_20050108/drivers/ide/ide-disk.c	2005-01-08 16:24:26.000000000 +0100
> @@ -1100,7 +1100,7 @@
>  	case idedisk_pm_idle:		/* Resume step 1 (idle) */
>  		args->tfRegister[IDE_COMMAND_OFFSET] = WIN_IDLEIMMEDIATE;
>  		args->command_type = IDE_DRIVE_TASK_NO_DATA;
> -		args->handler = task_no_data_intr;
> +		args->handler = &task_no_data_intr;

C101.

	Jeff



