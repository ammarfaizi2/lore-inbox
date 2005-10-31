Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751017AbVJaK13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbVJaK13 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 05:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbVJaK13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 05:27:29 -0500
Received: from mail.suse.de ([195.135.220.2]:56001 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751018AbVJaK12 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 05:27:28 -0500
Date: Mon, 31 Oct 2005 11:27:23 +0100
From: Olaf Hering <olh@suse.de>
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, Mark Tomich <tomichm@bellsouth.net>
Subject: Re: patch to add a config option to enable SATA ATAPI by default
Message-ID: <20051031102723.GA10037@suse.de>
References: <1130691328.8303.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1130691328.8303.8.camel@localhost>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sun, Oct 30, Mark Tomich wrote:

> Below is a very straight-forward patch to add a config option to
> enabling SATA ATAPI by default.

> diff -u -r linux-2.6.14-rc5/drivers/scsi/Kconfig
> linux-2.6.14-rc5-patched/drivers/scsi/Kconfig
> --- linux-2.6.14-rc5/drivers/scsi/Kconfig	2005-10-30 11:09:15.533533419 -0500
> +++ linux-2.6.14-rc5-patched/drivers/scsi/Kconfig	2005-10-30 11:21:39.735696058 -0500
> @@ -445,6 +445,17 @@
>  
>  	  If unsure, say N.
>  
> +config SCSI_SATA_ENABLE_ATAPI
> +	bool "Enable SATA ATAPI by default"

Jeff, will you apply this?

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
