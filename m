Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264985AbTFQVS2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 17:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264916AbTFQVR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 17:17:59 -0400
Received: from [195.208.223.247] ([195.208.223.247]:41856 "EHLO
	pls.park.msu.ru") by vger.kernel.org with ESMTP id S264987AbTFQVRg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 17:17:36 -0400
Date: Wed, 18 Jun 2003 01:30:58 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Matthew Wilcox <willy@debian.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Anton Blanchard <anton@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>, Greg KH <greg@kroah.com>
Subject: Re: pci_domain_nr vs. /sys/devices
Message-ID: <20030618013058.A686@pls.park.msu.ru>
References: <1055341842.754.3.camel@gaston> <20030611144801.GZ28581@parcelfarce.linux.theplanet.co.uk> <20030617044948.GA1172@krispykreme> <20030617134156.A2473@jurassic.park.msu.ru> <20030617124950.GF8639@krispykreme> <20030617171100.B730@jurassic.park.msu.ru> <20030617194227.GG24357@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030617194227.GG24357@parcelfarce.linux.theplanet.co.uk>; from willy@debian.org on Tue, Jun 17, 2003 at 08:42:27PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 17, 2003 at 08:42:27PM +0100, Matthew Wilcox wrote:
> How about this (PPC & Sparc64 will have to decide what they want to do
> for this case):

I'm fine with it.

> +/* We never have overlapping bus numbers on Alpha */

"Never" is not quite correct - "in general we don't have"
would be better. Full-sized Marvel can have up to 512 root buses.

Ivan.
