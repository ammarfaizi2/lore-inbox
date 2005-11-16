Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030196AbVKPGqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbVKPGqx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 01:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030195AbVKPGqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 01:46:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:37002 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751184AbVKPGqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 01:46:51 -0500
Date: Tue, 15 Nov 2005 22:18:13 -0800
From: Greg KH <gregkh@suse.de>
To: Adam Belay <abelay@novell.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 1/6] PCI PM: create pm.c and relocate PM functions
Message-ID: <20051116061813.GA31375@suse.de>
References: <1132111873.9809.50.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132111873.9809.50.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 10:31:13PM -0500, Adam Belay wrote:
> pci_save_state(), pci_restore_state(), pci_enable_wake(),
> pci_choose_state(), and pci_set_power_state() are moved to
> drivers/pci/pm.c.
> 
> This patch makes several code cleanups but no functional changes.

Looks good but:

> --- a/drivers/pci/pm.c	1969-12-31 19:00:00.000000000 -0500
> +++ b/drivers/pci/pm.c	2005-10-24 06:23:15.000000000 -0400
> @@ -0,0 +1,296 @@
> +/*
> + * pm.c - PCI Device Power Management
> + */ 

You should say where this came from, and the copyrights for that file.

thanks,

greg k-h
