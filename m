Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbWCTTq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbWCTTq7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 14:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964936AbWCTTq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 14:46:59 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:49096
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S964886AbWCTTq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 14:46:58 -0500
Date: Mon, 20 Mar 2006 11:46:42 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] pci_ids.h: correct naming of 1022:7450 (AMD 8131 Bridge)
Message-ID: <20060320194642.GA16935@suse.de>
References: <20060320193351.GC15746@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320193351.GC15746@tuxdriver.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 02:33:56PM -0500, John W. Linville wrote:
> The naming of the constant defined for PCI ID 1022:7450 does not seem
> to match the information at http://pciids.sourceforge.net/:
> 
> 	http://pci-ids.ucw.cz/iii/?i=1022
> 
> There 1022:7450 is listed as "AMD-8131 PCI-X Bridge" while 1022:7451
> is listed as "AMD-8131 PCI-X IOAPIC".  Yet, the current definition for
> 0x7450 is PCI_DEVICE_ID_AMD_8131_APIC.	It seems to me like that name
> should map to 0x7451, while a name like PCI_DEVICE_ID_AMD_8131_BRIDGE
> should map to 0x7450.

Yes, that's what the latest pci ids file shows, so this patch looks
correct, I'll add it to my queue.

thanks,

greg k-h
