Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964904AbVHOS54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbVHOS54 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 14:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbVHOS54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 14:57:56 -0400
Received: from mail.kroah.org ([69.55.234.183]:7302 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964904AbVHOS5z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 14:57:55 -0400
Date: Mon, 15 Aug 2005 11:57:32 -0700
From: Greg KH <greg@kroah.com>
To: Brett Russ <russb@emc.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 2.6.13-rc6] PCI/libata INTx cleanup
Message-ID: <20050815185732.GA15216@kroah.com>
References: <20050803204709.8BA0720B06@lns1058.lss.emc.com> <42FBA08C.5040103@pobox.com> <20050812171043.CF61020E8B@lns1058.lss.emc.com> <20050812182253.GA7842@suse.de> <42FD14E9.8060502@pobox.com> <20050812224303.F40A820E94@lns1058.lss.emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050812224303.F40A820E94@lns1058.lss.emc.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2005 at 06:43:03PM -0400, Brett Russ wrote:
> Simple cleanup to eliminate X copies of the pci_enable_intx() function
> in libata.  Moved ahci.c's pci_intx() to pci.c and use it throughout
> libata and msi.c.
> 
> Signed-off-by: Brett Russ <russb@emc.com>

It would have been nice if you had built this code :(

Hint, get rid of all TRUE and FALSE usages in your patch.  Care to try
again?

thanks,

greg k-h
