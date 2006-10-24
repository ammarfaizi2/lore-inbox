Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161266AbWJXWPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161266AbWJXWPI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 18:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161265AbWJXWPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 18:15:08 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:2713 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161259AbWJXWPD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 18:15:03 -0400
Message-ID: <453E8FB7.9090001@sgi.com>
Date: Tue, 24 Oct 2006 17:12:07 -0500
From: John Partridge <johnip@sgi.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Jeff Garzik <jeff@garzik.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: Ordering between PCI config space writes and MMIO reads?
References: <adafyddcysw.fsf@cisco.com> <20061024192210.GE2043@havoc.gtf.org>	<20061024214724.GS25210@parisc-linux.org> <adar6wxbcwt.fsf@cisco.com>
In-Reply-To: <adar6wxbcwt.fsf@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
>  > I think the right way to fix this is to ensure mmio write ordering in
>  > the pci_write_config_*() implementations.  Like this.
> 
> I'm happy to fix this in the PCI core and not force drivers to worry
> about this.
> 
> John, can you confirm that this patch fixes the issue for you?
> 
> Thanks,
>   Roland

I'll give it a try and get back to you.

John

-- 
John Partridge

Silicon Graphics Inc
Tel:  651-683-3428
Vnet: 233-3428
E-Mail: johnip@sgi.com
