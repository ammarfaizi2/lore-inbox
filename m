Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265470AbSJXOqM>; Thu, 24 Oct 2002 10:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265473AbSJXOqM>; Thu, 24 Oct 2002 10:46:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34833 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265470AbSJXOqH>;
	Thu, 24 Oct 2002 10:46:07 -0400
Message-ID: <3DB80919.5030500@pobox.com>
Date: Thu, 24 Oct 2002 10:52:09 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: "KOCHI, Takayoshi" <t-kouchi@mvf.biglobe.ne.jp>, jung-ik.lee@intel.com,
       tony.luck@intel.com, pcihpd-discuss@lists.sourceforge.net,
       linux-ia64@linuxia64.org, linux-kernel@vger.kernel.org
Subject: Re: PCI Hotplug Drivers for 2.5
References: <72B3FD82E303D611BD0100508BB29735046DFF3F@orsmsx102.jf.intel.com> <20021024051008.GA19557@kroah.com> <20021024145839.OAHRC0A82654.59A07363@mvf.biglobe.ne.jp> <20021024061236.GJ19557@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
>>The SHPC specification defines it still depends on ACPI for managing
>>resources, etc.  So resource management portion can be and *should be*
>>shared with all PCI hotplug drivers that use ACPI for resource
>>management.
>>
>>I think the most important thing is everyone agree on the direction
>>in which we should go before we code anything, in order not to waste
>>our time.
> 
> 
> I think we now all agree that resource management should move into a
> place where it can be shared by all pci hotplug drivers, right?
> 
> If so, anyone want to propose some common code?


drivers/pci/setup* is not enough?

I am surprised that anything needed to be added here...

