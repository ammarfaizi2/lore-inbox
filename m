Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274879AbRIZIPm>; Wed, 26 Sep 2001 04:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274877AbRIZIPd>; Wed, 26 Sep 2001 04:15:33 -0400
Received: from mail.zmailer.org ([194.252.70.162]:53517 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S274873AbRIZIPY>;
	Wed, 26 Sep 2001 04:15:24 -0400
Date: Wed, 26 Sep 2001 11:15:30 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Shawn Starr <shawn.starr@datawire.net>
Cc: lkm <linux-kernel@vger.kernel.org>
Subject: Re: HPNA 2.0 Information that might be helpful
Message-ID: <20010926111530.G11046@mea-ext.zmailer.org>
In-Reply-To: <3BB1485A.F964EF93@datawire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BB1485A.F964EF93@datawire.net>; from shawn.starr@datawire.net on Tue, Sep 25, 2001 at 11:15:38PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2001 at 11:15:38PM -0400, Shawn Starr wrote:
> http://www.homepna.org/docs/paper500.pdf
> I found this document via google and it tells you the format for an
> HPNA 2.0 frame
>   Shawn.

The HPNA looks, for all intents and purposes, as Ethernet.
The interesting question will be card drivers.

If card vendor writes a driver themselves, and sends it out
in source, we are happy.   If they give (to selected few
contact people) sufficient information for writing a driver,
that works too.

Reading the Broadcom  BCM4211 and BCM4413 product briefs
does give me an idea that the thing wont be quite simple.
That is, unless the Soft-V.90 is ditched.
(Biggest code is at that modem stuff anyway.)

Even writing a soft-modem into separate user-space entity
with only the low-level hardware driving in the kernel
is doable by letting the modem stuff to be binary-only.
For several reasons that is most likely appropriate way
even to do it.  Soft-modem has no place in kernel.

/Matti Aarnio
