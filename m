Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965308AbWADWnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965308AbWADWnS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965311AbWADWnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:43:18 -0500
Received: from cabal.ca ([134.117.69.58]:18825 "EHLO fattire.cabal.ca")
	by vger.kernel.org with ESMTP id S965308AbWADWnR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:43:17 -0500
Date: Wed, 4 Jan 2006 17:42:51 -0500
From: Kyle McMartin <kyle@mcmartin.ca>
To: Ben Collins <bcollins@ubuntu.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/15] i386: Handle HP laptop rebooting properly.
Message-ID: <20060104224250.GA32177@quicksilver.road.mcmartin.ca>
References: <0ISL004R0943MT@a34-mta01.direcway.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ISL004R0943MT@a34-mta01.direcway.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 04:59:44PM -0500, Ben Collins wrote:
> +	{	/* HP laptops have weird reboot issues */
> +		.callback = set_bios_reboot,
> +		.ident = "HP Laptop",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "HP Compaq"),
> +		},
> +	},
>  	{	/* Handle problems with rebooting on HP nc6120 */
>  		.callback = set_bios_reboot,
>  		.ident = "HP Compaq nc6120",
>

Looks like the entry below could be removed, as it's now covered by
the above.

Cheers,
	Kyle 
