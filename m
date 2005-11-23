Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030352AbVKWIEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030352AbVKWIEK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 03:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030357AbVKWIEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 03:04:10 -0500
Received: from main.gmane.org ([80.91.229.2]:59781 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030352AbVKWIEJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 03:04:09 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jani Monoses <jani.monoses@gmail.com>
Subject: Re: BUG 2.6.14.2 : ACPI boot lockup
Date: Wed, 23 Nov 2005 10:00:12 +0200
Message-ID: <dm17ih$67k$1@sea.gmane.org>
References: <20051122211947.GA29622@bougret.hpl.hp.com> <20051122165429.A30362@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: home03207.cluj.astral.ro
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051010)
X-Accept-Language: en-us, en
In-Reply-To: <20051122165429.A30362@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  drivers/acpi/scan.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6.14-vanilla/drivers/acpi/scan.c
> ===================================================================
> --- linux-2.6.14-vanilla.orig/drivers/acpi/scan.c
> +++ linux-2.6.14-vanilla/drivers/acpi/scan.c
> @@ -1111,7 +1111,7 @@ acpi_add_single_object(struct acpi_devic
>  	 *
>  	 * TBD: Assumes LDM provides driver hot-plug capability.
>  	 */
> -	result = acpi_bus_find_driver(device);
> +	acpi_bus_find_driver(device);
>  
>        end:
>  	if (!result)

Is this going into 2.6.15?

thanks
Jani

