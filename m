Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbVIUTGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbVIUTGq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 15:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbVIUTGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 15:06:46 -0400
Received: from bayc1-pasmtp04.bayc1.hotmail.com ([65.54.191.164]:4100 "EHLO
	BAYC1-PASMTP04.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1751182AbVIUTGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 15:06:45 -0400
Message-ID: <BAYC1-PASMTP04CC15E3DEFC1F2C129CC9AE940@cez.ice>
X-Originating-IP: [67.71.125.52]
X-Originating-Email: [seanlkml@sympatico.ca]
Message-ID: <44442.10.10.10.28.1127329602.squirrel@linux1>
In-Reply-To: <4331A65B.90103@tmr.com>
References: <Pine.LNX.4.58.0509192003410.2553@g5.osdl.org>   
    <200509201005.49294.gene.heskett@verizon.net>   
    <20050920141008.GA493@flint.arm.linux.org.uk>   
    <200509201025.36998.gene.heskett@verizon.net>
    <BAYC1-PASMTP04AB35B0A82E89B341AB0BAE950@cez.ice>
    <4331A65B.90103@tmr.com>
Date: Wed, 21 Sep 2005 15:06:42 -0400 (EDT)
Subject: Re: Arrr! Linux v2.6.14-rc2
From: "Sean" <seanlkml@sympatico.ca>
To: "Bill Davidsen" <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.4-2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 21 Sep 2005 19:06:14.0538 (UTC) FILETIME=[89986EA0:01C5BEDF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, September 21, 2005 2:28 pm, Bill Davidsen said:

> But that pulls the current tree, doesn't it? Not the git release?

It pulls the latest git release plus any extra commits that have been made
since, if any.   Now, if you have a specific reason to test a -gitX
release you can simply lookup which commit corresponds to the -gitX
release and check it out of the git repository and build it.   Actually, I
just posted a script that lets you check out a build by -gitX name instead
of having to manually lookup the corresponding commit id.

> For purposes of bug reporting and fixing, I would think that having some
> reproducible version is superior. If I say git3, anyone can get it, it
> would appear that "git pull" isn't as deterministic.

There are cases where using the -gitX release helps a bit.  But there's
nothing magic about a -gitX release, it's just a collection of whatever
commits existed when the timed build procedure ran.

Using git you get the choice of using -gitX builds or tracking directly
from the most recent commit as the situation demands.   Therefore if Linus
commits a fix beyond the latest -gitX release you happen to need, you're
good to go.  If you want to track the latest -gitX release, you can do
that with git too.

Sean

