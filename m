Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272136AbTG2VV1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 17:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272069AbTG2VSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 17:18:49 -0400
Received: from mail.hostrack.net ([67.120.136.74]:17931 "EHLO
	mail.hostrack.net") by vger.kernel.org with ESMTP id S272136AbTG2VQ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 17:16:27 -0400
Message-ID: <01e101c35616$859ddad0$0202a8c0@BOB>
From: "Ryan Flowers" <linux@ryanflowers.com>
To: <linux-kernel@vger.kernel.org>
References: <200307292038.h6TKcqlu000338@81-2-122-30.bradfords.org.uk> <20030729134046.A8007@grieg.holmsjoen.com>
Subject: Re: PATCH : LEDs - possibly the most pointless kernel subsystem ever
Date: Tue, 29 Jul 2003 14:15:22 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> On Tue, Jul 29, 2003 at 09:38:52PM +0100, John Bradford wrote:
> > Ah, I just thought, for debugging purposes we could have LEDs for:
> > 
> > * BKL taken
> > * Servicing interrupt
> > * Kernel stack usage > 2K
> 
> In the way olden days we used the console lights for a realtime
> display of buffer use on a PDP-11.  This type of realtime display
> can be most useful, especially if it's easily configurable.
> 
> -- 
> Randolph Bentson
> bentson@holmsjoen.com
> -
These ideas based on my experience in a production server environment, in
web hosting:

Temperature (Red/Yellow/Green LED)
CPU load (Red/Yellow/Green LED)
Out of Memory (blinking red?)

Don't imagine it would be hard to make a red LED status also set off an
alarm via the PC speaker. Although really a proper system will alert you of
these things anyway, but it would be nice to see it at a glance too.

Ryan Flowers - Reno NV 
http://www.ryanflowers.com

