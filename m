Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbWHQMfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWHQMfS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 08:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbWHQMfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 08:35:18 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:36266 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932340AbWHQMfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 08:35:16 -0400
Message-ID: <44E46280.2020109@garzik.org>
Date: Thu, 17 Aug 2006 08:35:12 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 0/75] pci_module_init to pci_register_driver conversion
References: <20060817042634.0.CrzcY28443.28439.michal@ltg01-fedora.pl> <20060817055814.GA14950@kroah.com>
In-Reply-To: <20060817055814.GA14950@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Thu, Aug 17, 2006 at 04:26:35AM +0000, Michal Piotrowski wrote:
>> Hi,
>>
>> pci_module_init is obsolete.
>>
>> This patch series converts pci_module_init to pci_register_driver.
>>
>>
>> Can I remove this?
>>
>> include/linux/pci.h:385
>> /*
>>  * pci_module_init is obsolete, this stays here till we fix up all usages of it
>>  * in the tree.
>>  */
>> #define pci_module_init pci_register_driver
> 
> As repeated numerous times, it's up to the network developers if they
> will take this or not.
> 
> I'll hold off on taking this series, please push it through the driver
> subsystem maintainers.

It's already in subsystem trees, in fact.

But it is most definitely not 2.6.18-rc material :)

	Jeff



