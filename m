Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262117AbVFHGS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbVFHGS7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 02:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbVFHGS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 02:18:58 -0400
Received: from mail.dvmed.net ([216.237.124.58]:51152 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262122AbVFHGSl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 02:18:41 -0400
Message-ID: <42A68DB5.9070900@pobox.com>
Date: Wed, 08 Jun 2005 02:18:29 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Andrew Grover <andy.grover@gmail.com>,
       "David S. Miller" <davem@davemloft.net>, tom.l.nguyen@intel.com,
       roland@topspin.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [RFC PATCH] PCI: remove access to pci_[enable|disable]_msi()
 for drivers - take 2
References: <20050607002045.GA12849@suse.de> <20050607202129.GB18039@kroah.com>	 <42A61CDE.6090906@pobox.com> <c0a09e5c05060722558a86ac8@mail.gmail.com>
In-Reply-To: <c0a09e5c05060722558a86ac8@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As an aside...

Never forget that hardware vendors _always_ want their latest stuff to 
the default <whatever>.  :)

In the grand scheme of things, I really don't see why we need to rush 
into anything, on the PCI MSI front.  Support exists.  Drivers work 
as-is today.  Is it terribly urgent to default PCI MSI on in 
pci_enable_device()?

Things are still shaking out with regards to broken devices, and broken 
system chipsets.

	Jeff



