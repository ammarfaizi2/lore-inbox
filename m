Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269722AbUHZXSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269722AbUHZXSd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 19:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269708AbUHZXPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 19:15:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6530 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269736AbUHZXO3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 19:14:29 -0400
Message-ID: <412E6EC3.4060606@pobox.com>
Date: Thu, 26 Aug 2004 19:14:11 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Bjorn Helgaas <bjorn.helgaas@hp.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: pci_disable_device kills hardware (was Re: [PATCH] propagate
 pci_enable_device() errors)
References: <200408261329.16825.bjorn.helgaas@hp.com> <412E3F93.9030503@pobox.com> <20040826224117.GC12762@kroah.com>
In-Reply-To: <20040826224117.GC12762@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Thu, Aug 26, 2004 at 03:52:51PM -0400, Jeff Garzik wrote:
> 
>>thanks much.
>>
>>We still need to figure out what to do for multiple-driver situations, 
>>since the additional of pci_disable_device() calls literally 
>>_guarantees_ failures in a two-drivers-for-the-same-hardware situation.
> 
> 
> the "two-drivers-for-the-same-hardware" is what needs to be fixed.
> You are on your own if you do that.


Sure, but that's handwaving away reality...  It stands to reason that we 
would all _prefer_ one driver for each piece of hardware.

	Jeff


