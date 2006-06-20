Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965118AbWFTHZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965118AbWFTHZr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 03:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965119AbWFTHZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 03:25:47 -0400
Received: from cantor2.suse.de ([195.135.220.15]:62186 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965118AbWFTHZq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 03:25:46 -0400
From: Andi Kleen <ak@suse.de>
To: Dave Olson <olson@unixfolk.com>
Subject: Re: [discuss] Re: [RFC] Whitelist chipsets supporting MSI and check Hyper-transport capabilities
Date: Tue, 20 Jun 2006 09:25:30 +0200
User-Agent: KMail/1.9.3
Cc: discuss@x86-64.org, Brice Goglin <brice@myri.com>,
       linux-kernel@vger.kernel.org, Greg Lindahl <greg.lindahl@qlogic.com>,
       gregkh@suse.de
References: <fa.5FgZbVFZIyOdjQ3utdNvbqTrUq0@ifi.uio.no> <fa.URgTUhhO9H/aLp98XyIN2gzSppk@ifi.uio.no> <Pine.LNX.4.61.0606192237560.25433@osa.unixfolk.com>
In-Reply-To: <Pine.LNX.4.61.0606192237560.25433@osa.unixfolk.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200606200925.30926.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Sure, that's true of almost everything new.   It remains broken until people
> start using it, complain, and get the bugs fixed.   Some of us have a vested
> interest in having MSI work, since it's the only way we can deliver interrupts.
> We've already worked with a few BIOS writers to get problems fixed, and we'll
> keep doing so as we find problems.   If enough hardware vendors and consumers
> do so, the broken stuff will get fixed, and stay fixed, because it will get
> tested.

Sometimes there are new things that work relatively well and only break occassionally
and then there are things where it seems to be the other way round.

My point was basically that every time we tried to turn on such a banana green feature
without white listing it was a sea of pain to get it to work everywhere
and tended to cause far too many non boots

(and any non boot is far worse than whatever performance advantage you get
from it) 

So if there are any more MSI problems comming up IMHO it should be white list/disabled 
by default and only turn on after a long time when Windows uses it by default 
or something. Greg, do you agree?

-Andi
