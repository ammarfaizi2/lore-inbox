Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264706AbTFQM5V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 08:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264709AbTFQM5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 08:57:21 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:3588 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S264706AbTFQM5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 08:57:20 -0400
Date: Tue, 17 Jun 2003 17:11:00 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Anton Blanchard <anton@samba.org>
Cc: Matthew Wilcox <willy@debian.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: pci_domain_nr vs. /sys/devices
Message-ID: <20030617171100.B730@jurassic.park.msu.ru>
References: <1055341842.754.3.camel@gaston> <20030611144801.GZ28581@parcelfarce.linux.theplanet.co.uk> <20030617044948.GA1172@krispykreme> <20030617134156.A2473@jurassic.park.msu.ru> <20030617124950.GF8639@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030617124950.GF8639@krispykreme>; from anton@samba.org on Tue, Jun 17, 2003 at 10:49:50PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 17, 2003 at 10:49:50PM +1000, Anton Blanchard wrote:
> A runtime test would be useful, at least for ppc64. That would allow our
> older machines to work (multiple host bridges without overlapping
> buses). What if we had pci_proc_max_domain and arch code could change its
> value during pcibios_init?

Maybe. Or pci_proc_max_domain(), which can be a macro or a real function,
depending on arch.

Ivan.
