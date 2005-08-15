Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964829AbVHOQcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbVHOQcE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 12:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbVHOQcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 12:32:04 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:17247 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S964828AbVHOQcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 12:32:00 -0400
Date: Mon, 15 Aug 2005 09:31:55 -0700
From: Greg KH <gregkh@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Brett Russ <russb@emc.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.13-rc6] PCI/libata INTx cleanup
Message-ID: <20050815163155.GB10257@suse.de>
References: <20050803204709.8BA0720B06@lns1058.lss.emc.com> <42FBA08C.5040103@pobox.com> <20050812171043.CF61020E8B@lns1058.lss.emc.com> <20050812182253.GA7842@suse.de> <42FD14E9.8060502@pobox.com> <20050812224303.F40A820E94@lns1058.lss.emc.com> <42FD3EDF.7050809@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42FD3EDF.7050809@pobox.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2005 at 08:29:19PM -0400, Jeff Garzik wrote:
> Brett Russ wrote:
> >Simple cleanup to eliminate X copies of the pci_enable_intx() function
> >in libata.  Moved ahci.c's pci_intx() to pci.c and use it throughout
> >libata and msi.c.
> >
> >Signed-off-by: Brett Russ <russb@emc.com>
> 
> Looks good to me.
> 
> Greg, do you want to queue this (since it touches PCI), or should I 
> (since it touches SATA drivers)?

I'll take it and add it to my trees and send it off to Linus after
2.6.13 comes out.

thanks,

greg k-h
