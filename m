Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271239AbTHMACS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 20:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271245AbTHMACS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 20:02:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64202 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S271239AbTHMACR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 20:02:17 -0400
Message-ID: <3F397FFB.9090601@pobox.com>
Date: Tue, 12 Aug 2003 20:02:03 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Matthew Wilcox <willy@debian.org>, davem@redhat.com,
       linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
References: <20030812020226.GA4688@zip.com.au> <1060654733.684.267.camel@localhost> <20030812023936.GE3169@parcelfarce.linux.theplanet.co.uk> <20030812053826.GA1488@kroah.com> <20030812112729.GF3169@parcelfarce.linux.theplanet.co.uk> <20030812180158.GA1416@kroah.com>
In-Reply-To: <20030812180158.GA1416@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> In the end, it's up to the maintainer of the driver what they want to
> do.  So, Jeff and David, here's a patch against the latest 2.6.0-test3
> tg3.c that converts the pci_device_id table to C99 initializers.  If you
> want to, please apply it.


it expands a few lines to a bazillion :(   I would rather leave it as 
is...  you'll find several PCI ethernet drivers with pci_device_id 
entries that fit entirely on one line, and I think that compactness has 
value at least to me.

	Jeff



