Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264993AbRFUO5A>; Thu, 21 Jun 2001 10:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264992AbRFUO4v>; Thu, 21 Jun 2001 10:56:51 -0400
Received: from inpbox.inp.nsk.su ([193.124.167.24]:37580 "EHLO
	inpbox.inp.nsk.su") by vger.kernel.org with ESMTP
	id <S264993AbRFUO4l>; Thu, 21 Jun 2001 10:56:41 -0400
Date: Thu, 21 Jun 2001 21:46:56 +0700
From: "Dmitry A. Fedorov" <D.A.Fedorov@inp.nsk.su>
Reply-To: D.A.Fedorov@inp.nsk.su
To: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
cc: Balbir Singh <balbir_soni@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Is it useful to support user level drivers
In-Reply-To: <01062115243900.01881@idun>
Message-ID: <Pine.SGI.4.10.10106212130280.3193032-100000@Sky.inp.nsk.su>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2001, Oliver Neukum wrote:

> > Lastly an IRQ kernel module can disable_irq() from interrupt handler
> > and enable it again only on explicit acknowledge from user.
> 
> Unless you need that interrupt to be enabled to deliver the signal or let 

Need not. Signal and other event delivery mechanisms has nothing
common with disable/enable_irq().

> userspace reenable the interrupt.

"user acknowledge" is mean that.


> In addition, how do you handle shared interrupts ?

It is impossible, see my another message.

