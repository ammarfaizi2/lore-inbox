Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbTKFSLb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 13:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbTKFSLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 13:11:30 -0500
Received: from modemcable137.219-201-24.mc.videotron.ca ([24.201.219.137]:24194
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263014AbTKFSL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 13:11:29 -0500
Date: Thu, 6 Nov 2003 13:10:52 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Robert Bird <rbird@Atlanticpositioners.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: reassigning IRQs for specific PCI slots...
In-Reply-To: <13811E54B99D7C4AA403E725583A356F0BBB72@mail-server.atlanticpositioners.com>
Message-ID: <Pine.LNX.4.53.0311061309380.27287@montezuma.fsmlabs.com>
References: <13811E54B99D7C4AA403E725583A356F0BBB72@mail-server.atlanticpositioners.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Nov 2003, Robert Bird wrote:

> We are trying to use RTLinux thread to service a PCI-based multi-port 
> serial card.  I have read several documents regarding "sharing IRQs", 
> using boot-prompt parameters, IO-APIC.txt, etc.  I am being told by the 
> RTLinux community that I must not share interrupts when using real-time 
> thread to service a PCI-based function.  I have tried using several 
> combinations of boot-prompt parameters (we are using GRUB) but have had 
> no success in redirecting IRQ assignment during boot-time!

If you don't have the option to assign irqs to specific slots in the BIOS 
you can try shuffling PCI adapters around. I take it you don't have an 
IOAPIC on the board?

