Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263969AbTKZGAJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 01:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263977AbTKZGAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 01:00:09 -0500
Received: from smtp02.web.de ([217.72.192.151]:33301 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S263969AbTKZGAF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 01:00:05 -0500
Subject: Re: 2.6.0-preX causes memory corruption
From: Ali Akcaagac <aliakc@web.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1069826410.907.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 26 Nov 2003 07:00:10 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > to go for new stuff 2 days later). So I bought brand new mobo,
> > ram, harddisk and stuff like that and build the system up:

> new power supply?

Yes that was the first thing I've replaced. My old 250W for a new 433W
although I must admit that the old PSU still works fine as it did for
the past 3.5 years for my old Gigabyte BX2000 and old Elitegroup K7S5A
(including all the stuff like HD, CD, GRAKA etc.) it consumed less than
250W. I'm educated electronics guy and tested the old PSU under stress
conditions e.g. with consumer connected only to check whether the
voltage or current break down or something. The new PSU should satisfy
my system more than one time.

> > really worried what the cause of this problem could be. I know
> > there could be dozen of reasons such as compiler used, stuff
> > compiled ...

> and which compiler did you use?

gcc (GCC) 3.3.2

But I doubt that this is Compiler related since I use this one even
before pre9 (where the system worked stable). This problem showed up the
first time within pre9 and still exists in pre10 and now that other
folks confirmed that there is some 'strange magic' inside the Kernel I
now feel more that this may be the case. It's no permanent thing or
something it happens every now and then.

I now gonna disable preempt and report back.

