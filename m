Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273235AbTG3Ski (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 14:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273236AbTG3Ski
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 14:40:38 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:8832 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S273235AbTG3Skh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 14:40:37 -0400
Date: Wed, 30 Jul 2003 19:50:04 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200307301850.h6UIo412000243@81-2-122-30.bradfords.org.uk>
To: john@grabjohn.com, pavel@suse.cz
Subject: Re: PATCH : LEDs - possibly the most pointless kernel subsystem ever
Cc: linux-kernel@vger.kernel.org, pgw99@doc.ic.ac.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > But this kind of blinkenlights needed pretty fast LEDs. (At 486 time
> > > I decided that parport on ISA is fast enough..)
> > 
> > I'll buy some LEDs and build a parallel port connected LED panel
> > tomorrow...  Do you think the overhead of driving the LEDs would have
> > too much of a negative effect on system performance?  If so, or if
> > we
>
> I'm not sure. At 486 days I was pretty sure it did not matter. These
> days you might get 10% slowdown on some microbenchmark, or something
> like that. I do not think it can slow down common tasks.

OK, so no problems there...

> My construction of LED lights is extremely flaky, and I'm afraid of
> burning printer port. At 486 days ports were expected to survive such
> abuse. Not sure if todays EPP/wtf ports can handle that.

This could be a problem, though - now I've looked in to it, the
maximum recommended current drain on the parallel port seems to be
really low :-(.

I've CC'ed Alan - maybe he can offer some advice.

(Alan - basically we're thinking of using this LED-on-parallel-port
driver for a standardised 'front panel', showing things like interrupt
being serviced, BKL taken, etc, for debugging purposes.)

John.
