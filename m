Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261585AbVCHWgC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbVCHWgC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 17:36:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVCHWgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 17:36:01 -0500
Received: from mail.tmr.com ([216.238.38.203]:26122 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261775AbVCHWcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 17:32:53 -0500
Date: Tue, 8 Mar 2005 17:21:00 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Jean Delvare <khali@linux-fr.org>
cc: linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: One more Asus SMBus quirk
In-Reply-To: <20050308232100.6a9248f2.khali@linux-fr.org>
Message-ID: <Pine.LNX.3.96.1050308171819.30801A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2005, Jean Delvare wrote:

> Hi Bill,
> 
> > > [PATCH] PCI: One more Asus SMBus quirk
> > > 
> > > One more Asus laptop requiring the SMBus quirk (W1N model).
> > 
> > Hopefully this and the double-free patch will be included in
> > 2.6.11.n+1?  They seem to fit the "real bug" criteria.
> 
> I see nothing critical in this patch. It gives access to a chip. Without
> the patch you cannot access the chip, and that's about it. No bug there,
> only a missing feature.

Sorry, I thought this was an non-functional feature in existing code
rather than support for a new chip. 
> 
> Can't speak for the "double-free patch", don't know what it is all
> about.
> 
> -- 
> Jean Delvare
> 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

