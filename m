Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267677AbTAMA5S>; Sun, 12 Jan 2003 19:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267680AbTAMA5S>; Sun, 12 Jan 2003 19:57:18 -0500
Received: from dsl092-067-143.bos1.dsl.speakeasy.net ([66.92.67.143]:26759
	"EHLO europa.beakerware.net") by vger.kernel.org with ESMTP
	id <S267677AbTAMA5R>; Sun, 12 Jan 2003 19:57:17 -0500
Date: Sun, 12 Jan 2003 20:08:42 -0500 (EST)
From: Michael Kingsbury <beaker@europa.beakerware.net>
To: William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: any chance of 2.6.0-test*?
In-Reply-To: <20030110161012.GD2041@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0301122002480.7225-100000@europa.beakerware.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Say, I've been having _smashing_ success with 2.5.x on the desktop and
> on big fat highmem umpteen-way SMP (NUMA even!) boxen, and I was
> wondering if you were considering 2.6.0-test* anytime soon.
> 
> I'd love to get this stuff out for users to hammer on ASAP, and things
> are looking really good AFAICT.
> 
> Any specific concerns/issues/wishlist items you want taken care of
> before doing it or is it a "generalized comfort level" kind of thing?
> Let me know, I'd be much obliged for specific directions to move in.

As long as I can't unzip the latest, do a quick

	'make xconfig' w/o changing the defaults,

	 followed by

	'make bzImage',

and actually get the sucker to compile, I'd say go for it.  But there's 
still too much breakage.  And until that breakage is fixed, you won't get 
the next wave of people (users) who are curious to poke around with it.  
(some of us don't care to take half a day just to figure out what to do to make something compile because 
there's problems in the source.)

(Yes, I realize I have to customize the kernel some.  But at the very 
least the defaults shouldn't cause it to fall flat on its face.)

-mike

