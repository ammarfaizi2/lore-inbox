Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbTFBUUa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 16:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbTFBUU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 16:20:29 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:14049 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262261AbTFBUUY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 16:20:24 -0400
Date: Mon, 2 Jun 2003 13:35:39 -0700
From: Greg KH <greg@kroah.com>
To: Mark Haverkamp <markh@osdl.org>
Cc: Pat Mochel <mochel@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pci bridge class code
Message-ID: <20030602203539.GA6353@kroah.com>
References: <1054239461.28608.74.camel@markh1.pdx.osdl.net> <20030530231348.GA22049@kroah.com> <1054585856.29244.0.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054585856.29244.0.camel@markh1.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 02, 2003 at 01:30:56PM -0700, Mark Haverkamp wrote:
> On Fri, 2003-05-30 at 16:13, Greg KH wrote:
> > On Thu, May 29, 2003 at 01:17:42PM -0700, Mark Haverkamp wrote:
> > > This adds pci-pci bridge driver model class code.  Entries appear in 
> > > /sys/class/pci_bridge.
> > 
> > Nice, but I don't see the need for the extra class information, as it
> > doesn't really give us anything new, right?  So without the class stuff
> > might be nice.
> > 
> 
> I'm not sure I understand what you are saying here.  Could you clarify?

The /sys/class/pci_bridge entries are redundant, as they don't show any
new info that isn't already in /sys/bus/pci/drivers/pci_bridge, right?
I don't think that class directory or the class_device stuff is
necessary.

thanks,

greg k-h
