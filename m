Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281168AbRKYWaA>; Sun, 25 Nov 2001 17:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281159AbRKYW3u>; Sun, 25 Nov 2001 17:29:50 -0500
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:27153 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S281168AbRKYW3g>; Sun, 25 Nov 2001 17:29:36 -0500
Date: Sun, 25 Nov 2001 17:29:29 -0500 (EST)
From: Mark Hahn <hahn@physics.mcmaster.ca>
To: Chris Wedgwood <cw@f00f.org>
cc: "Kevin P. Fleming" <kevin@labsysgrp.com>, linux-kernel@vger.kernel.org
Subject: Re: Disk hardware caching, performance, and journalling
In-Reply-To: <20011126111105.B10622@weta.f00f.org>
Message-ID: <Pine.LNX.4.10.10111251713010.7477-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     I think if you have a large mail server and zero power protection,
>     you've got much larger problems to worry about than write-behind
>     caching on your disk drives... my servers have never (in my
...
> In the specific case of email; you want to make certain guarantees,
> and having data written to non-volatile storage is one of them.

it's pitiful to pretend that this miniscule risk (50ms per catastrophic
power failure) is all that stands between you and absolute stability
of storage.

> People who assume that a small-window is small enough and decide that
> is 'good enough' are dangerous :)

your religious pursuits are your own business.  
the rest of the world will go on calculating probabilities of failure,
rather than emoting.  using raid, redundant sites, upses, etc, 
rather than obsessing on how terrible IDE disks are.

in summary: write caching on disks is *not* an impediment to robust systems.

I've omitted lkml from this reply since it has nothing to do with the kernel.

