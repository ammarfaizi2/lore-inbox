Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263138AbUDETOb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 15:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263151AbUDETOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 15:14:31 -0400
Received: from p508B6B24.dip.t-dialin.net ([80.139.107.36]:35345 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S263138AbUDETOa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 15:14:30 -0400
Date: Mon, 5 Apr 2004 21:14:21 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: drivers/char/dz.[ch]: reason for keeping?
Message-ID: <20040405191421.GE4462@linux-mips.org>
References: <20040404101241.A10158@flint.arm.linux.org.uk> <Pine.LNX.4.55.0404051504080.31851@jurand.ds.pg.gda.pl> <20040405141957.B31724@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040405141957.B31724@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2004 at 02:19:57PM +0100, Russell King wrote:

> > > Since we have drivers/serial/dz.[ch] now merged, is there a reason to
> > > keep drivers/char/dz.[ch] around any more?  I notice people keep doing
> > > cleanups, but this is wasted effort if the driver is superseded by the
> > > new drivers/serial/dz.[ch] driver.
> > 
> >  drivers/char/dz.[ch] has been verified to work on real hardware, at least 
> > with 2.4.  Can the same be said of drivers/serial/dz.[ch]?  If so, then 
> > the former can be removed from the mainline.
> 
> Ralf has verified that it works before he submitted it to Linus, so
> I guess that means that it does "work on real hardware".

That must be been some missunderstanding.  DECstations are still not
supported in 2.6 and therfore there was simply no way of testing.

I'm surprised drivers/char/dz.c still exists - I was pretty sure having
submitted a patch to delete it when drivers/serial/dz.c was submitted -
two is one too much.

  Ralf
