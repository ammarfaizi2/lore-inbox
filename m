Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265885AbTL3Sin (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 13:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265889AbTL3Sim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 13:38:42 -0500
Received: from mail.kroah.org ([65.200.24.183]:31980 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265885AbTL3Sij (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 13:38:39 -0500
Date: Tue, 30 Dec 2003 10:38:29 -0800
From: Greg KH <greg@kroah.com>
To: akpm@osdl.org, tlnguyen@snoqualmie.dp.intel.com, tom.l.nguyen@intel.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ia32 Message Signalled Interrupt support
Message-ID: <20031230183829.GA2564@kroah.com>
References: <200312300711.hBU7BPKX023057@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312300711.hBU7BPKX023057@hera.kernel.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 30, 2003 at 05:42:23AM +0000, Linux Kernel Mailing List wrote:
> ChangeSet 1.1496.22.9, 2003/12/29 21:42:23-08:00, akpm@osdl.org
> 
> 	[PATCH] ia32 Message Signalled Interrupt support
> 	
> 	From: long <tlnguyen@snoqualmie.dp.intel.com>
> 	
> 	
> 	Add support for Message Signalled Interrupt delivery on ia32.
> 	
> 	With a fix from Zwane Mwaikambo <zwane@arm.linux.org.uk>

<snip>

> diff -Nru a/drivers/pci/msi.c b/drivers/pci/msi.c
> --- /dev/null	Wed Dec 31 16:00:00 1969
> +++ b/drivers/pci/msi.c	Mon Dec 29 23:11:29 2003
> @@ -0,0 +1,1068 @@
> +/*
> + * linux/drivers/pci/msi.c
> + */

I'm guessing this file was written by Intel?  If so, can we please get a
copyright statement for it?  I'm getting tired of having to talk to
lawyers as it is...

thanks,

greg k-h
