Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262763AbULQHul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262763AbULQHul (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 02:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbULQHul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 02:50:41 -0500
Received: from gate.crashing.org ([63.228.1.57]:2437 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262763AbULQHtK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 02:49:10 -0500
Subject: Re: [linux-pm] Re: Cleanup PCI power states
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Andrew Morton <akpm@zip.com.au>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20041217000629.GB11531@kroah.com>
References: <20041116130445.GA10085@elf.ucw.cz>
	 <20041116155613.GA1309@kroah.com> <20041117120857.GA6952@openzaurus.ucw.cz>
	 <20041124234057.GF4649@kroah.com> <20041125113913.GC1027@elf.ucw.cz>
	 <20041217000629.GB11531@kroah.com>
Content-Type: text/plain
Date: Fri, 17 Dec 2004 08:48:46 +0100
Message-Id: <1103269727.14209.21.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-16 at 16:06 -0800, Greg KH wrote:

> > +EXPORT_SYMBOL(pci_choose_state);
> 
> EXPORT_SYMBOL_GPL() perhaps?

Ugh ? Why GPL only ? That's meant to be used by pretty much all
pci_driver's

Ben.

