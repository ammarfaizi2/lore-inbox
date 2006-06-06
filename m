Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWFFWbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWFFWbA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 18:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWFFWbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 18:31:00 -0400
Received: from ns.suse.de ([195.135.220.2]:55216 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751250AbWFFWbA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 18:31:00 -0400
Date: Tue, 6 Jun 2006 15:28:20 -0700
From: Greg KH <greg@kroah.com>
To: Ivan Novick <ivan@0x4849.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: #define pci_module_init pci_register_driver
Message-ID: <20060606222820.GA28733@kroah.com>
References: <1149587406.28634.263152113@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149587406.28634.263152113@webmail.messagingengine.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2006 at 10:50:06AM +0100, Ivan Novick wrote:
> Hi,
> 
> It seems an effort was made to replace all pci_module_init calls with
> pci_register_driver but in -mm it still seems to have pci_module_init
> for many drivers.

Yeah, can't seem to stomp all them out :)

> Does anyone know if this is still in the queue somewhere or if it was
> cancelled?  Is pci_register_driver the preferred call to make?

Yes, please call pci_register_driver() instead for all new code.

thanks,

greg k-h
