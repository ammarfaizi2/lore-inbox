Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261371AbSIWS0q>; Mon, 23 Sep 2002 14:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261372AbSIWS0p>; Mon, 23 Sep 2002 14:26:45 -0400
Received: from chaos.analogic.com ([204.178.40.224]:899 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261371AbSIWS0n>; Mon, 23 Sep 2002 14:26:43 -0400
Date: Mon, 23 Sep 2002 14:34:27 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Pavel Machek <pavel@suse.cz>
cc: Karim Yaghmour <karim@opersys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [PATCH] LTT for 2.5.37 2/9: Trace driver
In-Reply-To: <20020922003837.A35@toy.ucw.cz>
Message-ID: <Pine.LNX.3.95.1020923142959.6231A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Sep 2002, Pavel Machek wrote:

> Hi!
> 
> > +/*  Driver */
> > +static int		sMajorNumber;		/* Major number of the tracer */
> > +static int		sOpenCount;		/* Number of times device is open */
> > +/*  Locking */
> 
> Why *s*OpenCount? Some creeping infection by hungarian notation?
> 

int YesItLooksAsThoughSomeOfThisHasCreptIntoTheKernelAsWell = TRUE;

Methinks it started in a BusLogic driver and wasn't stamped out
before it spread and infected everything else!

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

