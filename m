Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262473AbTFKP2l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 11:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262437AbTFKP2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 11:28:41 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:20744 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262430AbTFKP2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 11:28:39 -0400
Date: Wed, 11 Jun 2003 16:42:20 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>
Subject: Re: pci_domain_nr vs. /sys/devices
Message-ID: <20030611164220.F16643@flint.arm.linux.org.uk>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	Matthew Wilcox <willy@debian.org>
References: <1055341842.754.3.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1055341842.754.3.camel@gaston>; from benh@kernel.crashing.org on Wed, Jun 11, 2003 at 04:30:42PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 04:30:42PM +0200, Benjamin Herrenschmidt wrote:
> The new pci_domain_nr() is good for adding the PCI domain number to
> the /sys/devices/pciN/* names, but I think that's not the proper
> representation. It should really be
> 
>   /sys/devices/pci-domainN/pciN/*

So, "pci-domainN" would be a device itself, separate from the "pciN"
device.  What physical hardware do these represent, or are they just
eye candy?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

