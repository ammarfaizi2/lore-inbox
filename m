Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264027AbTE3W6b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 18:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264028AbTE3W6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 18:58:31 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:15548 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264027AbTE3W6a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 18:58:30 -0400
Date: Fri, 30 May 2003 16:13:48 -0700
From: Greg KH <greg@kroah.com>
To: Mark Haverkamp <markh@osdl.org>
Cc: Pat Mochel <mochel@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pci bridge class code
Message-ID: <20030530231348.GA22049@kroah.com>
References: <1054239461.28608.74.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054239461.28608.74.camel@markh1.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29, 2003 at 01:17:42PM -0700, Mark Haverkamp wrote:
> This adds pci-pci bridge driver model class code.  Entries appear in 
> /sys/class/pci_bridge.

Nice, but I don't see the need for the extra class information, as it
doesn't really give us anything new, right?  So without the class stuff
might be nice.

> +MODULE_AUTHOR("Mark Haverkamp");
> +MODULE_DESCRIPTION("PCI bridge driver");
> +MODULE_LICENSE("GPL");

This isn't needed, as you can't build your code as a module with your
patch.

thanks,

greg k-h
