Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268860AbUIXQBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268860AbUIXQBN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 12:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268873AbUIXQBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 12:01:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:45463 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268860AbUIXQBM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 12:01:12 -0400
Date: Fri, 24 Sep 2004 09:00:05 -0700
From: Greg KH <greg@kroah.com>
To: "Luiz Fernando N. Capitulino" <lcapitulino@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] - adds missing checks in drivers/pci/probe.c.
Message-ID: <20040924160005.GA32411@kroah.com>
References: <20040920123326.753365b9.lcapitulino@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040920123326.753365b9.lcapitulino@conectiva.com.br>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2004 at 12:33:26PM -0300, Luiz Fernando N. Capitulino wrote:
> 
>  Hi Greg,
> 
>  I noticed drivers/pci/probe.c::pci_scan_bus_parented() has some functions which
> the return value is not checked.
> 
>  The patch bellow adds the check for device_register(), class_device_register(),
> class_device_create_file() and sysfs_create_link().
> 
> (hope the error label names are not too ugly).
> 
> 
> Signed-off-by: Luiz Capitulino <lcapitulino@conectiva.com.br>

Applied, thanks.

greg k-h
