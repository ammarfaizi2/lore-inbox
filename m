Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265249AbUD3UD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265249AbUD3UD7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 16:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265251AbUD3UD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 16:03:59 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:63728 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S265249AbUD3UCl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 16:02:41 -0400
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: Timothy Miller <miller@techsource.com>, Peter Williams <peterw@aurema.com>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Date: Fri, 30 Apr 2004 15:01:46 -0500
X-Mailer: KMail [version 1.2]
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Marc Boucher <marc@linuxant.com>, Sean Estabrooks <seanlkml@rogers.com>,
       Linus Torvalds <torvalds@osdl.org>, Paul Wagland <paul@wagland.net>,
       Rik van Riel <riel@redhat.com>, koke@sindominio.net,
       Rusty Russell <rusty@rustcorp.com.au>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Gibson <david@gibson.dropbear.id.au>
References: <Pine.LNX.4.44.0404291114150.9152-100000@chimarrao.boston.redhat.com> <4091D6D4.8070507@aurema.com> <40927A86.30207@techsource.com>
In-Reply-To: <40927A86.30207@techsource.com>
MIME-Version: 1.0
Message-Id: <04043015014600.23067@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 30 April 2004 11:10, Timothy Miller wrote:
> Peter Williams wrote:
> >> "DriverLoader technology is the ideal Linux solution to support
> >> devices for
> >>  which no adequate native open-source drivers are available. It also
> >> allows
> >>  vendors to drastically reduce time to market or eliminate the need to
> >> support
> >>  multiple drivers for Windows and Linux. By using the same driver on
> >> both platforms, significant resources can be saved."
> >>
> >> Rusty was right.
> >
> > Why did you omit the next paragraph (which completes the story):
> >
> > "We have attempted to reduce the inconvenience of binary-only drivers by
> > separating the proprietary code from the operating-system specific code.
> > The latter is provided in source form, allowing users to install the
> > drivers under any supported version (2.4 or later) of the Linux kernel."
>
> While it does allow for Linux to get certain kinds of drivers quicker,
> it turns hardware developers into slackers who don't want to REALLY
> support Linux and eats away at the spirit of Linux as an open system.
>
> What you're doing may short-term enhance hardware support for Linux, but
> in the long term, it is a set-back for Linux because it does not
> encourage hardware vendors to support Linux directly and even pushes
> true Linux support further into the future.

And worse -

It hangs the users out to dry if the vendor drops support of the
driver/hardware.

With full source code the community or the user would be able to continue
to update/fix the driver for new kernels.
