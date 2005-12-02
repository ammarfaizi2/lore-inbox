Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbVLBVtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbVLBVtE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 16:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbVLBVtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 16:49:03 -0500
Received: from mail.dvmed.net ([216.237.124.58]:49891 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750823AbVLBVtC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 16:49:02 -0500
Message-ID: <4390C149.8020001@pobox.com>
Date: Fri, 02 Dec 2005 16:48:57 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <matthew@wil.cx>, "Brown, Len" <len.brown@intel.com>
Subject: Re: [2.6.15-rc4] oops in acpiphp
References: <4390B646.60709@pobox.com> <20051202214054.GB3948@suse.de>
In-Reply-To: <20051202214054.GB3948@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Greg KH wrote: > On Fri, Dec 02, 2005 at 04:01:58PM
	-0500, Jeff Garzik wrote: > >>Booting with acpiphp on this dual core,
	dual package (2x2) box causes an >>oops. > > > Hm, this is oopsing in
	the pci express hotplug driver, not the acpi > hotplug driver. Did you
	mean to load that driver? [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Fri, Dec 02, 2005 at 04:01:58PM -0500, Jeff Garzik wrote:
> 
>>Booting with acpiphp on this dual core, dual package (2x2) box causes an 
>>oops.
> 
> 
> Hm, this is oopsing in the pci express hotplug driver, not the acpi
> hotplug driver.  Did you mean to load that driver? 

Yes.  I didn't look too closely beyond 'pci hotplug oops' TBH, since my 
machine wouldn't boot.


> I'll look at your other attachments for more details...

Thanks,

	Jeff


