Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161069AbWAGXk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161069AbWAGXk3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 18:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161070AbWAGXk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 18:40:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:26321 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161069AbWAGXk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 18:40:28 -0500
Date: Sat, 7 Jan 2006 15:40:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, shemminger@osdl.org
Subject: Re: 2.6.15-mm2
Message-Id: <20060107154006.6ade772d.akpm@osdl.org>
In-Reply-To: <43C04B93.9020503@reub.net>
References: <20060107052221.61d0b600.akpm@osdl.org>
	<43BFD8C1.9030404@reub.net>
	<20060107133103.530eb889.akpm@osdl.org>
	<43C03B4A.1060501@reub.net>
	<43C04B93.9020503@reub.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reuben Farrelly <reuben-lkml@reub.net> wrote:
>
> Replying to myself is not a good thing but:
> 
> On 8/01/2006 11:06 a.m., Reuben Farrelly wrote:
> > 
> > 
> > On 8/01/2006 10:31 a.m., Andrew Morton wrote:
> >> Reuben Farrelly <reuben-lkml@reub.net> wrote:
> >>> ...
> >>> QLogic Fibre Channel HBA Driver
> >>> ahci: probe of 0000:00:1f.2 failed with error -12
> >>
> >> It's odd that the ahci driver returned -EBUSY.  Maybe this is due to "we
> >> have legacy mode, but all ports are unavailable" in ata_pci_init_one().
> > 
> > I've now removed this driver from my .config via menuconfig, I certainly 
> > don't have the hardware and have no idea whatsoever how it came to be 
> > built in. Although I guess it shouldn't be blowing up even if that is 
> > the case?
> 
> I thought I'd clear up that I only removed the QLogic driver, and not AHCI ;-)
> 

That message was caused by the ahci driver.  
