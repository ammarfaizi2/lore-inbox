Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbUENTwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbUENTwW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 15:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbUENTwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 15:52:22 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:50704 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262391AbUENTwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 15:52:15 -0400
Date: Fri, 14 May 2004 20:52:12 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Marc Singer <elf@buici.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: arm-lh7a40x IDE support in 2.6.6
Message-ID: <20040514205212.A19539@flint.arm.linux.org.uk>
Mail-Followup-To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Marc Singer <elf@buici.com>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <200405141840.04401.bzolnier@elka.pw.edu.pl> <20040514172656.GA18884@buici.com> <200405142045.51875.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200405142045.51875.bzolnier@elka.pw.edu.pl>; from B.Zolnierkiewicz@elka.pw.edu.pl on Fri, May 14, 2004 at 08:45:51PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2004 at 08:45:51PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Friday 14 of May 2004 19:26, Marc Singer wrote:
> > On Fri, May 14, 2004 at 06:40:04PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > I was just porting my patches killing <asm/arch/ide.h> for
> > > ARM to 2.6.6 when noticed that more work is needed now. :-(
> > >
> > > arch/arm/mach-lh7a40x/ide-lpd7a40x.c
> > > include/asm-arm/arch-lh7a40x/ide.h
> > >
> > > Why it couldn't be done in drivers/ide/arm
> > > (as discussed on linux-ide)?
> >
> > Your response took look enough for me to switch to another job.  I
> > haven't yet returned to dealing with this.
> 
> Yes, it took too long.
> 
> Anyway, pushing non-working code to mainline is a bad thing
> (I can show some proofs for this statement).

It was a necessary step.  To get around this, we're going to ask people
to submit new machine support on a file by file basis, and that's just
not practical, and you can't expect me to be able to track _every_
_single_ fscking change to the kernel, and pick up every one in a
review.

There will always be a delay between changes happening between two people
and we have to live with it.  Not everyone works on Linus' latest kernel.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
