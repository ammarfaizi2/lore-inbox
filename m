Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271186AbTHCN6g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 09:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271188AbTHCN6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 09:58:35 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:53395 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP id S271186AbTHCN6e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 09:58:34 -0400
From: root@mauve.demon.co.uk
Message-Id: <200308031358.OAA09299@mauve.demon.co.uk>
Subject: Re: 2.6.0-test2 pegasus USB ethernet system lockup.
To: greg@kroah.com (Greg KH)
Date: Sun, 3 Aug 2003 14:58:35 +0100 (BST)
Cc: root@mauve.demon.co.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20030803041144.GA18501@kroah.com> from "Greg KH" at Aug 02, 2003 09:11:44 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Sun, Aug 03, 2003 at 01:22:07AM +0100, root@mauve.demon.co.uk wrote:
> > Occasionally I also get 
> > Aug  1 01:47:37 mauve kernel: Debug: sleeping function called from invalid context at drivers/usb/core/hcd.c:1350
> 
> This is fixed in Linus's tree.
> 
> > I am unable to say if lights are flashing on the keyboard, as there are 
> > no lights on the keyboard.
> 
> Can you use a serial debug console and/or the nmi watchdog to see if you
> can capture where things went wrong?

Currently trying to get the NMI watchdog working.

Is it not possible to get all kernel messages written to the VGA text screen
so that it's at least as reliable as the serial console?
The screen is perfectly visible.

I have plugged a PS/2 connector into the docking station, and can confirm
that there are no lights flashing.
