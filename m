Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbTIXRjb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 13:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbTIXRja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 13:39:30 -0400
Received: from meetpoint.leesburg-geeks.org ([66.63.28.250]:4358 "EHLO
	meetpoint.home") by vger.kernel.org with ESMTP id S261522AbTIXRjZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 13:39:25 -0400
Date: Wed, 24 Sep 2003 13:39:26 -0400 (EDT)
From: Ken Ryan <newsryan@leesburg-geeks.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: log-buf-len dynamic
Message-ID: <Pine.LNX.4.21.0309241338190.2021-100000@meetpoint.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrea Arcangeli <andrea@suse.de> wrote in message news:<yYdq.qV.23@gated-at.bofh.it>...
> On Tue, Sep 23, 2003 at 06:06:00PM +0200, Willy Tarreau wrote:
> > why do you want to force people to do something the way you think is best ?
> 
> because it gives you no real disavantage to pass the parameter in grub.
> You've to set root=/dev/root anyways, this way you would simply need to
> add the parameter for log buf as well. I've always to add lots of other
> stuff anyways, including vga= profile= etc..
> 
> > I personnaly think that both solutions are a convenient way of achieving the
> > same goal for different people. Please let them choose.
> 
> they can already choose with the parameter at boot, it's not that I
> don't let them choose.


I would like to add my two pennies...

At home I have a box with 4 IDE controllers (8 channels).  Up to and
including 2.4.20 I needed a kernel parameter list specifying
addresses, ata66, etc. for all but ide0 and ide1, as well as another
couple tweaks.  I literally was *at* the line length limit.  While my
specific situation was eased by .21 and .22 (all I need now is
'ide=reverse'), IMVHO as long as there is a hard limit on the
parameter line length it would be very nice to have the option of
minimizing what needs to be specified.

(FWIW I use lilo; I've never tried grub.  I haven't actually looked
whether the line length limit is in lilo or the kernel.)

            Ken Ryan

