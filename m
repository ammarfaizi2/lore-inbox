Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbVBLWVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVBLWVO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 17:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVBLWVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 17:21:14 -0500
Received: from dialin-159-245.tor.primus.ca ([216.254.159.245]:3456 "EHLO
	node1.opengeometry.net") by vger.kernel.org with ESMTP
	id S261206AbVBLWVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 17:21:10 -0500
Date: Sat, 12 Feb 2005 17:21:04 -0500
From: William Park <opengeometry@yahoo.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: irq 10: nobody cared! (was: Re: 2.6.11-rc3-mm1)
Message-ID: <20050212222104.GA1965@node1.opengeometry.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050204103350.241a907a.akpm@osdl.org> <20050205224558.GB3815@ime.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050205224558.GB3815@ime.usp.br>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2005 at 08:45:58PM -0200, Rog?rio Brito wrote:
> Dear developers,
> 
> For some kernel versions (say, since 2.6.10 proper, all the 2.6.11-rc's,
> some -mm trees and also -ac) I have been getting the message "irq 10:
> nobody cared!".
> 
> The message says that I should pass the irqpoll option to the kernel and
> even if I do, I still get the stack trace and the "irq 10: nobody cared!"
> message. :-(
> 
> The message seems to be related to the Promise PDC20265 driver and it
> appeared right after I moved my HDs from my motherboard's VIA controllers
> to the Promise controllers. I have an Asus A7V board, with 2 VIA 686a
> controllers and 2 Promise PDC20265 controllers.
> 
> I already tried enabling and disabling ACPI, but it seems that the problem
> just doesn't go away. :-(
> 
> I am including the dmesg log of my system with this message. I am CC'ing
> the linux-ide list, but I'm only subscribed to linux-kernel. I would
> appreciate CC's, if possible.
> 
> 
> Thank you very much for any help, Rog?rio.
> 
> P.S.: I am, right now, re-compiling 2.6.11-rc3-mm1 with the extra pass of
> kallsyms to see if the problem persists with this release.

Try 'acpi=noirq'.

-- 
William Park <opengeometry@yahoo.ca>, Toronto, Canada
Slackware Linux -- because I can type.
