Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266140AbUBCTXj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 14:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266129AbUBCTXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 14:23:31 -0500
Received: from 212-214-141-249.v-by.wtnord.net ([212.214.141.249]:17284 "EHLO
	ricercar.mine.nu") by vger.kernel.org with ESMTP id S266083AbUBCSZk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 13:25:40 -0500
Date: Tue, 3 Feb 2004 19:23:36 +0100
From: Daniel Brahneborg <daniel.com@wtnord.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Daniel Brahneborg <daniel.com@wtnord.net>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Status of Promise drivers?
Message-ID: <20040203192336.A5570@nettis.grimsta>
References: <20031230200012.C14399@nettis.grimsta> <3FF1CCC1.3050304@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3FF1CCC1.3050304@pobox.com>; from jgarzik@pobox.com on Tue, Dec 30, 2003 at 02:06:41PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Continued from an earlier discussion on the linux-raid list.)

I made the mistake of getting a Highpoint Rocket 1540 instead
of a Promise SATA card, and I simply can't get it to work
with the hpt366 driver in the kernel.  The driver from Highpoint
works better, but only works for the RedHat 2.4.20-8 kernel,
so I won't bother anybody with the problems with that one.

A major factor seems to be the KT600 chipset on the Abit KV7
motherboard. Is this a known issue?

On Tue, Dec 30, 2003 at 02:06:41PM -0500, Jeff Garzik wrote:
> Daniel Brahneborg wrote:
> > I'm having serious problems with my Silicon Image SATA card,
> > and am considering replacing with a (more expensive) Promise
> > SATA TX2 Plus card.
> > 
> > First I have some questions, to avoid getting into the same
> > mess as I'm in now.
> > 
> >  1. What is the status of the Promise driver?  Stable for
> >     everybody? (The SI3112 has problems for some people when
> >     using the IDE driver, and for some with the SCSI driver.)
> >     A binary module is ok, a binary bzImage definately is not.
> 
> It's beta, and stable.

Since I'm paranoid: What motherboards has it been tested and
verified with?

> >  3. Has anybody used it with *2* network cards?  Bonus
> >     points for the builtin Via Rhine and an 8139 card.
> >     (The SCSI driver for the SI3112 kills the machine when a
> >     second card is activated.)

Interestingly enough, the Highpoint card has the same effect
when activating the first network card (it doesn't matter which
one), but only with the 2.4 kernel. The 2.6 kernel works fine.
Again, could this be a motherboard issue?

/Basic

