Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318170AbSIBADv>; Sun, 1 Sep 2002 20:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318173AbSIBADu>; Sun, 1 Sep 2002 20:03:50 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:35319 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S318170AbSIBADu>; Sun, 1 Sep 2002 20:03:50 -0400
Subject: Re: OOPS: USB and/or devicefs
From: Nicholas Miell <nmiell@attbi.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, mochel@osdl.org
In-Reply-To: <20020901205859.A29797@flint.arm.linux.org.uk>
References: <1030270093.1531.8.camel@entropy>
	<20020828054647.GA26390@kroah.com> <1030908511.1374.17.camel@entropy> 
	<20020901205859.A29797@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 01 Sep 2002 17:08:13 -0700
Message-Id: <1030925294.1452.2.camel@entropy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-01 at 12:58, Russell King wrote:
> On Sun, Sep 01, 2002 at 12:28:30PM -0700, Nicholas Miell wrote:
> > On Tue, 2002-08-27 at 22:46, Greg KH wrote:
> > > Does this still happen on 2.5.32?  I was unable to reproduce it on
> > > either 2.5.31, 2.5.31-bk, or 2.5.32.
> > > 
> > 
> > I can reproduce the oops reliably -- but you have to enable slab
> > poisoning to do it.
> 
> You want to apply zwane's USB patch, and my 2.5.32-usb.diff patch.
> Both appeared on lkml today.  It should fix this precise problem.
> 

2.5.33 + my minor compilation fixes + "[PATCH] 2.5.32-usb" +
"[PATCH][2.5] pci_free_consistent on ohci initialisation failure" +
"[PATCH][2.5] set pci dma mask for ohci-hcd" still results in the same
oops.

Was there another USB patch today from Zwane that I missed?

