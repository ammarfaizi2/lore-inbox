Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262082AbVGOVzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262082AbVGOVzu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 17:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbVGOVzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 17:55:50 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64264 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262082AbVGOVyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 17:54:21 -0400
Date: Fri, 15 Jul 2005 22:54:17 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: karl malbrain <karl@petzent.com>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9 chrdev_open: serial_core: uart_open
Message-ID: <20050715225417.E23709@flint.arm.linux.org.uk>
Mail-Followup-To: karl malbrain <karl@petzent.com>,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <20050715215845.D23709@flint.arm.linux.org.uk> <NDBBKFNEMLJBNHKPPFILGEAMCEAA.karl@petzent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <NDBBKFNEMLJBNHKPPFILGEAMCEAA.karl@petzent.com>; from karl@petzent.com on Fri, Jul 15, 2005 at 02:17:01PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2005 at 02:17:01PM -0700, karl malbrain wrote:
> > -----Original Message-----
> > From: Russell King
> > Sent: Friday, July 15, 2005 1:59 PM
> > To: karl malbrain
> > Cc: Linux-Kernel@Vger. Kernel. Org
> > Subject: Re: 2.6.9 chrdev_open: serial_core: uart_open
> >
> >
> > On Fri, Jul 15, 2005 at 01:52:15PM -0700, karl malbrain wrote:
> > > On my 2.6.9-11EL source it clearly shows the up(&tty_sem) after
> > the call to
> > > uart_open. Init_dev never touches tty_sem.
> >
> > In which case, I have to say...
> >
> > Congratulations!  You've found a bug with Red Hat's Enterprise Linux
> > kernel!  Go straight to Red Hat's bugzilla!  Do not collect 200$.  Do
> > not pass go.
> >
> > Seriously though, this bug is not present in mainline kernels, so I
> > can't resolve this issue for you.  Mainline kernels appear to work
> > properly.
> 
> Could tty_io.c be all that changed by a small set of red-hat patches to
> 2.6.9?  Why would they need to go in there to make so many changes in the
> first place?  Which 2.6 release changed tty_io.c's use of tty_sem so
> heavily?

These are questions to ask of Red Hat, and can only be answered by
their representatives.

Thanks anyway, and I'm sorry that this hasn't been resolved given
the amount of time put into it by both of us.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
