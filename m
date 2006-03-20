Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751605AbWCTIJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbWCTIJn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 03:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWCTIJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 03:09:43 -0500
Received: from vidtam.ministry.se ([62.95.69.218]:44458 "EHLO
	vidtam.ministry.se") by vger.kernel.org with ESMTP id S1751604AbWCTIJn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 03:09:43 -0500
Date: Mon, 20 Mar 2006 09:09:09 +0100 (MET)
From: kernel@ministry.se
X-X-Sender: fwadmin@celeborn.ministry.se
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: "kernel@ministry.se" <kernel@ministry.se>, <Valdis.Kletnieks@vt.edu>,
       <linux-kernel@vger.kernel.org>
Subject: Re: kernel cache mem bug(?)
In-Reply-To: <9a8748490603170009s4685c0cpc1b05a410d7a975b@mail.gmail.com>
Message-ID: <Pine.GHP.4.44.0603200654330.18694-100000@celeborn.ministry.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > >     Workaround: When we disable HyperThreading in BIOS, this
> > > >     problem goes away. We re-enabling HT, it comes back...
> > >
> > > Have you ruled out marginal memory, or overclocking/overheating?
> >
> > No overclocking done, no overheating happening. All RAM memory checks
> > turn out just fine, with and without HT.
> >
>
> When you say "All RAM memory checks turn out just fine" do you mean
> the BIOS memory checks or something else?
>
> For a proper memory test run memtest86 (http://www.memtest86.com/)
> and/or memtest86+ (http://www.memtest.org/) overnight (some 8-12hours
> or more) with all tests enabled.. If the machine survives without
> errors that then you can be reasonably sure memory is OK... The BIOS
> tests are more or less worthless.

The RAM is 100% OK, both according to the initial BIOS memory check and
memtest86 running for more than four (4) hours straight.

One more thing that we just noticed: it seems the cache corruption (or
whatever it is)  only occurs when X is running.

//D

