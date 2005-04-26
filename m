Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbVDZRMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbVDZRMn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 13:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbVDZRMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 13:12:42 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:17280 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S261666AbVDZRMd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 13:12:33 -0400
Date: Tue, 26 Apr 2005 13:12:31 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Grant Grundler <grundler@parisc-linux.org>
cc: "Richard B. Johnson" <linux-os@analogic.com>,
       Alexander Nyberg <alexn@dsv.su.se>, Greg KH <greg@kroah.com>,
       Amit Gud <gud@eth.net>, <linux-kernel@vger.kernel.org>,
       <linux-pci@atrey.karlin.mff.cuni.cz>, <akpm@osdl.org>,
       <jgarzik@pobox.com>, <cramerj@intel.com>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [PATCH] PCI: Add pci shutdown ability
In-Reply-To: <20050426161907.GD2612@colo.lackof.org>
Message-ID: <Pine.LNX.4.44L0.0504261311290.12725-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2005, Grant Grundler wrote:

> On Tue, Apr 26, 2005 at 12:07:41PM -0400, Richard B. Johnson wrote:
> > DMAs don't go on "forever"
> 
> They don't. But we also don't know when they will stop.
> E.g. NICs will stop DMA when the RX descriptor ring is full.
> I don't know when USB stop on it's own.

USB doesn't stop DMA on its own.  It goes on forever until it's told to
stop or it encounters an error.

Alan Stern

