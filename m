Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbUKGRiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbUKGRiX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 12:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbUKGRiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 12:38:23 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:5063 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261294AbUKGRiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 12:38:21 -0500
Subject: Re: [no problem] PC110 broke 2.6.9
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, vojtech@ucw.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0411061851300.2223@ppc970.osdl.org>
References: <20041106232228.GA9446@apps.cwi.nl>
	 <Pine.LNX.4.58.0411061529200.2223@ppc970.osdl.org>
	 <1099791769.5564.118.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0411061851300.2223@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1099845291.5564.120.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 07 Nov 2004 16:34:52 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-11-07 at 02:57, Linus Torvalds wrote:
> > driver IBM shipped with the PC110. It's a pre pci, pre dmi machine so
> > there aren't any obvious sane ways to probe. Its not something you'd
> > want to build in as opposed to modular on any other system but the PC110
> 
> Well, that actually _is_ something we can probe for: "does this machine 
> have PCI". 
> 
> IOW, we could have a trivial "if the list of PCI devices is non-empty, 
> then return immediately" kind of thing, no?

Works for me

