Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbVBMBmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVBMBmF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 20:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVBMBmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 20:42:04 -0500
Received: from dialin-209-183-21-100.tor.primus.ca ([209.183.21.100]:28800
	"EHLO node1.opengeometry.net") by vger.kernel.org with ESMTP
	id S261231AbVBMBl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 20:41:59 -0500
Date: Sat, 12 Feb 2005 20:41:51 -0500
From: William Park <opengeometry@yahoo.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: irq 10: nobody cared! (was: Re: 2.6.11-rc3-mm1)
Message-ID: <20050213014151.GA2735@node1.opengeometry.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050204103350.241a907a.akpm@osdl.org> <20050205224558.GB3815@ime.usp.br> <20050212222104.GA1965@node1.opengeometry.net> <20050212224715.GA8249@ime.usp.br> <20050212232134.GA2242@node1.opengeometry.net> <20050212235043.GA4291@ime.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050212235043.GA4291@ime.usp.br>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2005 at 09:50:43PM -0200, Rog?rio Brito wrote:
> On Feb 12 2005, William Park wrote:
> > This looks awefully like 'acpi' is on.  If 'acpi=noirq' does not work,
> > then try 'pci=noacpi'.
> 
> Hi, Willian.
> 
> First of all, thank you very much for both your attention and help.
> 
> Unfortunately, I have already tried booting the 2.6.11-rc3-mm2 that I just
> compiled and I tried using many boot parameters like "acpi=noirq",
> "irqpoll", "pci=noacpi", "acpi=off" and setting the BIOS of my motherboard
> to "Plug'n'Play OS = Yes" (instead of "Off", which is my default).
> 
> To prevent the matters of loosing track of what is being done, I only
> changed one option at a time. I put the dmesg logs of all my attempts at
> <http://www.ime.usp.br/~rbrito/ide-problem/>.
> 
> Please let me know if I can provide any other useful information.

Your 'dmesg' says
    Warning: Secondary channel requires an 80-pin cable for operation.
I assume it is.

Do you have MSI on by any chance?  (CONFIG_PCI_MSI)  If so, try kernel
without it.  My motherboard exhibits runaway IRQ with it.

-- 
William Park <opengeometry@yahoo.ca>, Toronto, Canada
Slackware Linux -- because I can type.
