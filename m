Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261818AbVF0V2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbVF0V2v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 17:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbVF0V1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 17:27:20 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:43223 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261775AbVF0V0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 17:26:17 -0400
Date: Mon, 27 Jun 2005 16:25:48 -0500 (CDT)
From: Pat Gefre <pfg@americas.sgi.com>
To: Christoph Hellwig <hch@infradead.org>
cc: Pat Gefre <pfg@sgi.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Altix - add ioc3 serial driver support
In-Reply-To: <20050626184557.GA21428@infradead.org>
Message-ID: <Pine.SGI.3.96.1050627161134.39433C-100000@fsgi900.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jun 2005, Christoph Hellwig wrote:

+ On Wed, Jun 22, 2005 at 03:24:05PM -0500, Pat Gefre wrote:
+ > 
+ > I have a patch : ftp://oss.sgi.com/projects/sn2/sn2-update/042-ioc3-support
+ > 
+ > This driver adds support for a 2 port PCI IOC3 serial card on Altix boxes.
+ 
+ We already have an ioc3 driver, and despite beeing in drivers/net/ it
+ also registers the uarts.  If the very simple serial support in there
+ is not enough for you please improve it instead of adding a new separate
+ driver.  That improvement could involve a split similar to what Brent
+ did for ioc4 recently.
+ 

Something I didn't make clear - the driver that I am adding is a pci
card based on the IOC3 serial part - it is a single function card - 2
serial ports. This is supported on Altix.

The driver that is in drivers/net is to support a (full) IOC3 card -
ethernet and serial ports. This is not supported on Altix. Only the
newer IOC4 is supported (it also has serial ports among other things).

They are two different pieces of hardware.

-- Pat

