Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262648AbUENUYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbUENUYh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 16:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbUENUYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 16:24:37 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:55229 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262625AbUENUYe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 16:24:34 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: arm-lh7a40x IDE support in 2.6.6
Date: Fri, 14 May 2004 22:25:19 +0200
User-Agent: KMail/1.5.3
Cc: Marc Singer <elf@buici.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <200405141840.04401.bzolnier@elka.pw.edu.pl> <200405142045.51875.bzolnier@elka.pw.edu.pl> <20040514205212.A19539@flint.arm.linux.org.uk>
In-Reply-To: <20040514205212.A19539@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405142225.19339.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 of May 2004 21:52, Russell King wrote:
> On Fri, May 14, 2004 at 08:45:51PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Friday 14 of May 2004 19:26, Marc Singer wrote:
> > > On Fri, May 14, 2004 at 06:40:04PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > > I was just porting my patches killing <asm/arch/ide.h> for
> > > > ARM to 2.6.6 when noticed that more work is needed now. :-(
> > > >
> > > > arch/arm/mach-lh7a40x/ide-lpd7a40x.c
> > > > include/asm-arm/arch-lh7a40x/ide.h
> > > >
> > > > Why it couldn't be done in drivers/ide/arm
> > > > (as discussed on linux-ide)?
> > >
> > > Your response took look enough for me to switch to another job.  I
> > > haven't yet returned to dealing with this.
> >
> > Yes, it took too long.
> >
> > Anyway, pushing non-working code to mainline is a bad thing
> > (I can show some proofs for this statement).
>
> It was a necessary step.  To get around this, we're going to ask people
> to submit new machine support on a file by file basis, and that's just
> not practical, and you can't expect me to be able to track _every_
> _single_ fscking change to the kernel, and pick up every one in a
> review.

Nobody expects this but expecting people to try building they patches
against latest & greatest kernel before pushing to Linus is sane & practical.
-> ask people to submit patches which are buildable.

> There will always be a delay between changes happening between two people
> and we have to live with it.  Not everyone works on Linus' latest kernel.

