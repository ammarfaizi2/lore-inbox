Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265689AbUAHRyl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 12:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265692AbUAHRyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 12:54:39 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:20496 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265689AbUAHRy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 12:54:29 -0500
Date: Thu, 8 Jan 2004 17:54:22 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Leonid Grossman <leonid.grossman@s2io.com>
Cc: "'Grant Grundler'" <grundler@parisc-linux.org>,
       "'Jesse Barnes'" <jbarnes@sgi.com>, linux-kernel@vger.kernel.org,
       jeremy@sgi.com, "'Matthew Wilcox'" <willy@debian.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Jame.Bottomley@steeleye.com
Subject: Re: [RFC] Relaxed PIO read vs. DMA write ordering
Message-ID: <20040108175422.A13247@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Leonid Grossman <leonid.grossman@s2io.com>,
	'Grant Grundler' <grundler@parisc-linux.org>,
	'Jesse Barnes' <jbarnes@sgi.com>, linux-kernel@vger.kernel.org,
	jeremy@sgi.com, 'Matthew Wilcox' <willy@debian.org>,
	linux-pci@atrey.karlin.mff.cuni.cz, Jame.Bottomley@steeleye.com
References: <20040108063829.GC22317@colo.lackof.org> <005b01c3d603$d01b6c90$0400a8c0@S2IOtech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <005b01c3d603$d01b6c90$0400a8c0@S2IOtech.com>; from leonid.grossman@s2io.com on Thu, Jan 08, 2004 at 08:23:49AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 08, 2004 at 08:23:49AM -0800, Leonid Grossman wrote:
> Yes, this is exactly how (at least our 10GbE) PCI-X ASICs work.
> If the RO bit is set, the device decides whether the transaction
> requires strong ordering,
> and sets RO attribute accordingly.

Do you have a pointer to the driver source?  This would probably
make a good reference driver for Jesse's suggestion.

