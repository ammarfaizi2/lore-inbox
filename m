Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267859AbTBKRKy>; Tue, 11 Feb 2003 12:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267879AbTBKRKy>; Tue, 11 Feb 2003 12:10:54 -0500
Received: from main.gmane.org ([80.91.224.249]:3717 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S267859AbTBKRKw>;
	Tue, 11 Feb 2003 12:10:52 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jason Lunz <lunz@falooley.org>
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3 / aa / rmap with contest]
Date: Tue, 11 Feb 2003 17:17:47 +0000 (UTC)
Organization: PBR Streetgang
Message-ID: <slrnb4ic5v.4gi.lunz@stoli.localnet>
References: <20030209133013.41763.qmail@web41404.mail.yahoo.com> <20030209144622.GB31401@dualathlon.random> <20030210162301.GB443@elf.ucw.cz> <20030211114936.GE22275@dualathlon.random> <20030211124330.GK930@suse.de> <slrnb4i27n.3s0.lunz@stoli.localnet> <20030211144143.GR930@suse.de>
X-Complaints-To: usenet@main.gmane.org
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

axboe@suse.de said:
>> By all means, do the same thing with disk i/o. It's been a smashing
>> success with packet queueing.
> 
> Well, that's the point.

Yes, what you've done with cbq is great. What I was referring to,
though, is the user configurability of network frame queueing. It's
possible to do really complex things for very specialized needs, yet
also easy to put in a simple tweak if there's just one type of traffic
you need to prioritize.  It'd be nice to have that kind of
configurability for unusual i/o loads, and the arbitrary queue stacking
is a whole different beast than having a couple of tunables to tweak.

Jason

