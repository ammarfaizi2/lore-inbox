Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270003AbTHCQaV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 12:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271207AbTHCQaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 12:30:20 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:1685 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP id S270003AbTHCQaT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 12:30:19 -0400
From: root@mauve.demon.co.uk
Message-Id: <200308031630.RAA10225@mauve.demon.co.uk>
Subject: Re: 2.6.0-test2 pegasus USB ethernet system lockup.
To: root@mauve.demon.co.uk
Date: Sun, 3 Aug 2003 17:30:21 +0100 (BST)
Cc: greg@kroah.com (Greg KH), linux-kernel@vger.kernel.org
In-Reply-To: <200308031358.OAA09299@mauve.demon.co.uk> from "root@mauve.demon.co.uk" at Aug 03, 2003 02:58:35 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > 
> > On Sun, Aug 03, 2003 at 01:22:07AM +0100, root@mauve.demon.co.uk wrote:
> > > Occasionally I also get 
> > > Aug  1 01:47:37 mauve kernel: Debug: sleeping function called from invalid context at drivers/usb/core/hcd.c:1350
> > 
> > This is fixed in Linus's tree.
> > 
> > > I am unable to say if lights are flashing on the keyboard, as there are 
> > > no lights on the keyboard.
> > 
> > Can you use a serial debug console and/or the nmi watchdog to see if you
> > can capture where things went wrong?
> 
> Currently trying to get the NMI watchdog working.

I have failed to get it working.
I tried both of the options under CPU features to enable the APIC, with
both settings of the kernel flag.
I also tried a SMP kernel, with no flag.
None of these showed any NMI interrupts in /proc/interrupts or any different
behaviour on unplugging with the network active.
Is a serial kernel likely to do anything in this case?
