Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267874AbTGHXKy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 19:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267887AbTGHXKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 19:10:54 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:7436 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267874AbTGHXKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 19:10:53 -0400
Date: Wed, 9 Jul 2003 00:25:28 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: fbdev and power management
In-Reply-To: <20030704042052.GL4359@himi.org>
Message-ID: <Pine.LNX.4.44.0307090024170.32323-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm trying to get the radeon M6 in my new Fujitsu Lifebook to handle
> ACPI S3 suspend and resume properly - at the moment, on resume it
> fails to do anything. Looking at the driver, the reason is quite
> obvious (no .suspend and .resume functions defined), but the driver
> file has code to handle these (apparently only for the PowerBooks,
> since it's wrapped in a #ifdef CONIG_PMAC_PBOOK). My Lifebook P2120
> is a Crusoe 5800 based setup, with a PCI M6, so it's not even being
> built, let alone enabled and used. 
> 
> As far as I can tell, if I removed the #ifdef CONFIG_PMAC_PBOOK and
> split the current radeon_set_suspend up into suspend and resume
> functions to fit the current power management stuff, it might have
> some chance of working. Can you tell me if this is a reasonable
> first step?
> 
> Alternatively, if you have patches that I could test, I'd be quite
> happy to give them a go - being a guinea pig sounds like fun ;-)

No patches at this time. I need to learn the new power management code. 
Where are the docs for them ? 


