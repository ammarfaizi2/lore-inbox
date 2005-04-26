Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261686AbVDZRYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbVDZRYP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 13:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVDZRWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 13:22:36 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:53966 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261686AbVDZRTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 13:19:50 -0400
Subject: Re: [PATCH] PCI: Add pci shutdown ability
From: Lee Revell <rlrevell@joe-job.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Grant Grundler <grundler@parisc-linux.org>,
       "Richard B. Johnson" <linux-os@analogic.com>,
       Alexander Nyberg <alexn@dsv.su.se>, Greg KH <greg@kroah.com>,
       Amit Gud <gud@eth.net>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, akpm@osdl.org, jgarzik@pobox.com,
       cramerj@intel.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0504261311290.12725-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0504261311290.12725-100000@iolanthe.rowland.org>
Content-Type: text/plain
Date: Tue, 26 Apr 2005 13:19:48 -0400
Message-Id: <1114535988.5410.4.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-26 at 13:12 -0400, Alan Stern wrote:
> On Tue, 26 Apr 2005, Grant Grundler wrote:
> 
> > On Tue, Apr 26, 2005 at 12:07:41PM -0400, Richard B. Johnson wrote:
> > > DMAs don't go on "forever"
> > 
> > They don't. But we also don't know when they will stop.
> > E.g. NICs will stop DMA when the RX descriptor ring is full.
> > I don't know when USB stop on it's own.
> 
> USB doesn't stop DMA on its own.  It goes on forever until it's told to
> stop or it encounters an error.

Ditto sound cards.  Once you start capture or playback the device will
DMA to/from the assigned area forever.

Lee

