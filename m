Return-Path: <linux-kernel-owner+w=401wt.eu-S1161093AbXALVrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161093AbXALVrw (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 16:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161096AbXALVrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 16:47:52 -0500
Received: from smtp.osdl.org ([65.172.181.24]:37050 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161093AbXALVrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 16:47:51 -0500
Date: Fri, 12 Jan 2007 13:44:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, jkosina@suse.cz,
       linux-input@atrey.karlin.mff.cuni.cz, Adrian Bunk <bunk@stusta.de>
Subject: Re: Fwd: [PATCH] Fix some ARM builds due to HID brokenness
Message-Id: <20070112134405.af4465c0.akpm@osdl.org>
In-Reply-To: <20070112210015.GA2923@dyn-67.arm.linux.org.uk>
References: <20070112210015.GA2923@dyn-67.arm.linux.org.uk>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2007 21:00:15 +0000
Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> Could we please have this (or a proper fix) in before 2.6.20 to resolve
> the regression please?
> 
>
> ...
>
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -6,6 +6,7 @@ menu "HID Devices"
>  
>  config HID
>  	tristate "Generic HID support"
> +	depends on INPUT
>  	default y
>  	---help---
>  	  Say Y here if you want generic HID support to connect keyboards,
> 

This was merged a week ago..
