Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264814AbTFLLBz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 07:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264816AbTFLLBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 07:01:55 -0400
Received: from inconnu.isu.edu ([134.50.8.55]:19100 "EHLO inconnu.isu.edu")
	by vger.kernel.org with ESMTP id S264814AbTFLLBv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 07:01:51 -0400
Date: Thu, 12 Jun 2003 05:15:21 -0600 (MDT)
From: I Am Falling I Am Fading <skuld@anime.net>
X-X-Sender: skuld@inconnu.isu.edu
To: John Bradford <john@grabjohn.com>
cc: davej@codemonkey.org.uk, <gregor.essers@web.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Via KT400 and AGP 8x Support
In-Reply-To: <200306120827.h5C8RSEV000896@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.44.0306120512320.13378-100000@inconnu.isu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jun 2003, John Bradford wrote:

> > The only other solution is to kick your card down into AGP 2.0 mode, which
> > most BIOSes do not allow you to do in software. Instead what you have to
> > do is cut/unsolder traces on your video card for the pins used for AGP 3.0
> > detection. This is a near-permanent and horrible solution but it does get
> > everything working. :-/
> 
> Insulating tape on certain pins works on ISA cards, but whether it would be
> practical on the smaller pins of an AGP card, I'm not sure.

Tried it already... The pins are too small to get adequate purchase for 
the tape -- the friction just causes it to slide around in the slot and 
gets goo around.

Superglue might be a better solution....

...but I think the solder method is better.

On the Radeon 9700 Pro at least there are a couple jumpers on the 
appropriate pins, bridged by 0-ohm surface mount resistors (i.e. simple 
conductors). What you can do is just unsolder the bridges and it becomes 
an AGP 2.0 card... If you have a very steady hand you can also resolder 
them to get your AGP 3.0 back.

Still this is not a fun solution as you can potentially cook your card 
(make sure to use a 15 watt iron, nothing higher).

-----
James Sellman -- ISU CoE-CS/ISLUG Linux Lab Admin   |"Lum, did you just see
----------------------------------------------------| a hentai rabbit flying
skuld@inconnu.isu.edu      |   // A4000/604e/60 128M| through the air?"
skuld@anime.net            | \X/  A500/20 3M        |   - Miyake Shinobu

