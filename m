Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754469AbWKHJVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754469AbWKHJVy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 04:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754473AbWKHJVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 04:21:54 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:26986 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1754469AbWKHJVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 04:21:54 -0500
Date: Wed, 8 Nov 2006 11:21:50 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-input@atrey.karlin.mff.cuni.cz,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>,
       Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       Greg KH <greg@kroah.com>
Subject: Re: DMA APIs gumble grumble
Message-ID: <20061108092150.GB3405@rhun.haifa.ibm.com>
References: <1162950877.28571.623.camel@localhost.localdomain> <20061108082536.GA3405@rhun.haifa.ibm.com> <1162975653.28571.723.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162975653.28571.723.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2006 at 07:47:33PM +1100, Benjamin Herrenschmidt wrote:

> I agree, though, device_ext sucks as a name, you are welcome to propose
> something better, I'm no good at finding names :-)

Seems a lot like `pci_sysdata' on x86-64 and i386 with Jeff's PCI
domains support. dev_sysdata? naming is not my strong suit :-)

struct pci_sysdata {
	int		domain;    /* PCI domain */
	int		node;	   /* NUMA node */
	void*           iommu;	   /* IOMMU private data */
};
