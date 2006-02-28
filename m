Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750946AbWB1JpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbWB1JpW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 04:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbWB1JpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 04:45:22 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:11942 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750946AbWB1JpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 04:45:21 -0500
Subject: Re: libata PATA patch for 2.6.16-rc5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christian Trefzer <ctrefzer@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060228003039.GA13335@zeus.uziel.local>
References: <1141054370.3089.0.camel@localhost.localdomain>
	 <20060228003039.GA13335@zeus.uziel.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 28 Feb 2006 09:49:49 +0000
Message-Id: <1141120189.3089.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-02-28 at 01:30 +0100, Christian Trefzer wrote:
> On Mon, Feb 27, 2006 at 03:32:50PM +0000, Alan Cox wrote:
> > This is at
> > 	http://zeniv.linux.org.uk/~alan/IDE
> > 
> 
> Got this working like a charm, although I had to add the promise 20269's
> PCI IDs to ata_generic.c to make it tick. I only regard this as an
> interim solution, but wanted to try out getting rid of IDE altogether.
> So far it "feels" alright, using pata_via and ata_generic. Thanks a
> bunch!

Thanks for the report. The PDC20268 and 2027x are driven by Albert Lee's
Promise driver which should end up in the main tree soon, probably
before my PATA bits. 

