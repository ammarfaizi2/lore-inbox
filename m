Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbUCHXNZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 18:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbUCHXNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 18:13:24 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:6101 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id S261396AbUCHXMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 18:12:08 -0500
Date: Tue, 9 Mar 2004 00:11:38 +0100 (MET)
From: Arjen Verweij <A.Verweij2@ewi.tudelft.nl>
Reply-To: a.verweij@student.tudelft.nl
To: Craig Bradney <cbradney@zip.com.au>
cc: Ross Dickson <ross@datscreative.com.au>,
       "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       <linux-kernel@vger.kernel.org>, Jamie Lokier <jamie@shareable.org>,
       Ian Kumlien <pomac@vapor.com>, Jesse Allen <the3dfxdude@hotmail.com>,
       Daniel Drake <dan@reactivated.net>
Subject: Re: [PATCH] 2.6, 2.4, Nforce2, Experimental idle halt workaround
 instead of apic ack delay.
In-Reply-To: <1078786761.9399.15.camel@athlonxp.bradney.info>
Message-ID: <Pine.GHP.4.44.0403090007110.9764-100000@elektron.its.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, but for me the temp diff in Celsius between idle and load for the CPU
is almost 20 degrees. This has a dramatic impact on the case temperature
when it is closed because I haven't added fans in the top of the case yet.

So you see I value the disconnect quite a bit. Maybe when I get better
cooling I will disable it altogether in the BIOS so this headache will
disappear forever ;)

Arjen

On Mon, 8 Mar 2004, Craig Bradney wrote:

> Hi Arjen
>
> <snip>
>
> > So far I have seen this only once, and I don't know what causes it.
> >
> > Ross, I prefer using your old patch because it keeps my temperature within
> > reasonable bounds when the case is closed. Sorry.
> >
>
> <snip>
>
> I have put the idle=C1halt patch that Ross released a little while back
> now into Gentoo-dev-sources-2.6.3 as I reported to the list yesterday. I
> no longer use the old apic_tack=2 patch. I have been playing silly
> buggers with hardware, but so far the PC has made it to 11 hours and now
> 7 hours with no issues.
>
> After those 11 hours I decided I'd change the PC setup in here and
> disconnected a fan and a hard drive and moved my server s/w (apache etc)
> to this PC so I only have one in here fpr now.
>
> Right now, CPU is at 34C which is only 1-3C higher than with the other
> patch, including having one less fan sucking air out the back of the
> box. Motherboard is actually lower (27C) than before (29C). Ambient room
> temp is normal.
>
> After those 11 hours, I am quite sure that on normal use (ie not
> compiling) the motherboard and cpu was 1-2C lower than with apic_tack=2.
>
> regards
> Craig
>

