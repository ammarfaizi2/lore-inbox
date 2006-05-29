Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbWE2V4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWE2V4R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbWE2V4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:56:17 -0400
Received: from mail.kroah.org ([69.55.234.183]:47238 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751394AbWE2V4P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:56:15 -0400
Date: Mon, 29 May 2006 14:47:53 -0700
From: Greg KH <greg@kroah.com>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Greg KH <gregkh@suse.de>
Subject: Re: searching for pci busses
Message-ID: <20060529214753.GD10875@kroah.com>
References: <4478DCF1.8080608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4478DCF1.8080608@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28, 2006 at 01:12:26AM +0159, Jiri Slaby wrote:
> Hello,
> 
> I want to ask, if there is any function to call (as we debated with Jeff), which
> does something like this:
> 1) I have some vendor/device ids in table
> 2) I want to traverse raws of the table and compare to system devices, and if
> found, stop and return pci_dev struct (or raw in the table).

What's wrong with pci_match_id()?

Or just using the pci_register_driver() function properly, which handles
all of this logic for you?

thanks,

greg k-h
