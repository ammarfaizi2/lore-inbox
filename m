Return-Path: <linux-kernel-owner+willy=40w.ods.org-S313946AbUKBCjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S313946AbUKBCjI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 21:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264231AbUKBCjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 21:39:07 -0500
Received: from gate.crashing.org ([63.228.1.57]:687 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S313702AbUKBCir (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 21:38:47 -0500
Subject: Re: [linux-pm] Adapt drivers to type-safe pci
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Brownell <david-b@pacbell.net>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Pavel Machek <pavel@ucw.cz>, Patrick Mochel <mochel@digitalimplant.org>,
       Greg KH <greg@kroah.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200411011700.46493.david-b@pacbell.net>
References: <20041101202640.GA24855@elf.ucw.cz>
	 <200411011700.46493.david-b@pacbell.net>
Content-Type: text/plain
Date: Tue, 02 Nov 2004 13:31:24 +1100
Message-Id: <1099362684.29690.414.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-01 at 18:00 -0700, David Brownell wrote:
> On Monday 01 November 2004 12:26, Pavel Machek wrote:
> > Hi!
> > 
> > This adapts few drivers to type-safe pci powermanagment. I introduced
> > device_to_pci_state helper that will be usefull to few drivers... Does
> > it look okay? 
> 
> I'd rather have something like the attached patch.
> Fixed policy mappings are generically broken; what
> about devices that don't support PCI_D2?
> 
> This should I guess use the new "pci_power_t", but
> I'm not that current yet.  

Your snipped (please, inline, don't attach) would mean D2 is to be
preferred over D3 at all times ?

Ben.


