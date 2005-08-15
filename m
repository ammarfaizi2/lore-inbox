Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964919AbVHOUHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964919AbVHOUHK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 16:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbVHOUHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 16:07:09 -0400
Received: from mail.kroah.org ([69.55.234.183]:50337 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964920AbVHOUHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 16:07:08 -0400
Date: Mon, 15 Aug 2005 13:06:37 -0700
From: Greg KH <greg@kroah.com>
To: Brett Russ <russb@emc.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 2.6.13-rc6] PCI/libata INTx cleanup
Message-ID: <20050815200637.GA15871@kroah.com>
References: <20050803204709.8BA0720B06@lns1058.lss.emc.com> <42FBA08C.5040103@pobox.com> <20050812171043.CF61020E8B@lns1058.lss.emc.com> <20050812182253.GA7842@suse.de> <42FD14E9.8060502@pobox.com> <20050812224303.F40A820E94@lns1058.lss.emc.com> <20050815185732.GA15216@kroah.com> <4300E83F.1090401@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4300E83F.1090401@emc.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2005 at 03:08:47PM -0400, Brett Russ wrote:
> Greg KH wrote:
> >On Fri, Aug 12, 2005 at 06:43:03PM -0400, Brett Russ wrote:
> >
> >>Simple cleanup to eliminate X copies of the pci_enable_intx() function
> >>in libata.  Moved ahci.c's pci_intx() to pci.c and use it throughout
> >>libata and msi.c.
> >>
> >>Signed-off-by: Brett Russ <russb@emc.com>
> >
> >
> >It would have been nice if you had built this code :(
> >
> >Hint, get rid of all TRUE and FALSE usages in your patch.  Care to try
> >again?
> >
> >thanks,
> >
> >greg k-h
> 
> 
> Hmm, I did build it before submitting, saw not even a warning.  So I 
> just rebuilt it again to verify, and same thing.  Why would my tree work 
> and not yours?  config file?

You don't have MSI enabled in yours :(

thanks,

greg k-h
