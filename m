Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262581AbUKQX5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262581AbUKQX5k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 18:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262567AbUKQX4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 18:56:03 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:45485 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262607AbUKQWEf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 17:04:35 -0500
Date: Wed, 17 Nov 2004 14:03:10 -0800
From: Greg KH <greg@kroah.com>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Documentation/pci.txt inconsistency
Message-ID: <20041117220310.GB1291@kroah.com>
References: <200411171334.56492@bilbo.math.uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411171334.56492@bilbo.math.uni-mannheim.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2004 at 01:34:56PM +0100, Rolf Eike Beer wrote:
> The examples in section 2 of Documentation/pci.txt use pci_get_*. Some lines
> later there is this funny little paragraph:
> 
> > Note that these functions are not hotplug-safe.  Their hotplug-safe
> > replacements are pci_get_device(), pci_get_class() and pci_get_subsys().
> > They increment the reference count on the pci_dev that they return.
> > You must eventually (possibly at module unload) decrement the reference
> > count on these devices by calling pci_dev_put().
> 
> How about this:
> 
> These functions are hotplug-safe. They increment the reference count on the
> pci_dev that they return. You must eventually (possibly at module unload)
> decrement the reference count on these devices by calling pci_dev_put().

Great, care to send a patch instead?

thanks,

greg k-h
