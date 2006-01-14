Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751327AbWANWMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbWANWMP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 17:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWANWMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 17:12:15 -0500
Received: from xenotime.net ([66.160.160.81]:37819 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751327AbWANWMO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 17:12:14 -0500
Date: Sat, 14 Jan 2006 14:12:10 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: sbp2 address space
Message-Id: <20060114141210.567eab77.rdunlap@xenotime.net>
In-Reply-To: <43C2D899.2080302@s5r6.in-berlin.de>
References: <43BFAEE9.7090707@s5r6.in-berlin.de>
	<43C2D899.2080302@s5r6.in-berlin.de>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Jan 2006 22:41:45 +0100 Stefan Richter wrote:

> I wrote:
> > Does PCIe provide a bigger host bus address space than PCI?
> 
> PCIe obviously supports 64bit addressing. Do newer revisions of 
> conventional PCI support more than 32bit addressing? What about PCI-X? TIA.

PCI-X allows 32-bit or 64-bit transfers.
IIRC, PCI conventional supports 64-bit by "DAC" == dual-address cycle,
basically 2 32-bit transfers.

> [sbp2 depends on a <= 32bit address space of the host bus. Single-chip 
> FireWire PCIe adapters are available now but I believe they are merely 
> based on a PCI FireWire link layer controller plus PCI-PCIe bridge.]

The PCI specs cost money, else we could just download and read them.  :(

Google found some hits, mostly marketing-speak, and this
1394b PCI-64bit host controller:
  http://tekgems.com/Products/MJ-FW-PCI-13.htm

---
~Randy
