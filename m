Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267920AbUHKDmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267920AbUHKDmX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 23:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267921AbUHKDmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 23:42:23 -0400
Received: from out009pub.verizon.net ([206.46.170.131]:50385 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S267920AbUHKDmO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 23:42:14 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Tue, 10 Aug 2004 23:42:12 -0400
User-Agent: KMail/1.6.82
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <20040808113930.24ae0273.akpm@osdl.org> <200408100012.08945.gene.heskett@verizon.net>
In-Reply-To: <200408100012.08945.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408102342.12792.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [151.205.9.122] at Tue, 10 Aug 2004 22:42:13 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 August 2004 00:12, Gene Heskett wrote:
>On Sunday 08 August 2004 14:39, Andrew Morton wrote:
>>Gene Heskett <gene.heskett@verizon.net> wrote:
>>> On Thursday 05 August 2004 23:24, Linus Torvalds wrote:
>>>
>>> [...]
>>>
>>> >I'll commit the obvious one-liner fix, since it might explain
>>> > _some_ problems people have seen.
>>> >
>>> >		Linus

Linus, I hate to be a killjoy on this, but I just had to reboot again, 
it was killing processes, even first the shells I had open then kmail 
and X this time, but with nothing in the logs, and when X had quit, a 
top in the launching shell reported nearly 250 megs free with nothing 
in the swap.

So I'm not getting any usefull data, the machine is dog slow:
real    17m51.460s
user    13m11.201s
sys     1m34.718s

That should have been 6 minutes maximum.

I got rc4 as the whole thing just now, maybe there was something wrong 
with the 2.6.7 base I was using.  Thats rare since I quit getting 
the .bz2's, switching to tar.gz's which seem to be the more 
dependable format here.

>>> I had to reboot late last night, out of memory and things (like
>>> mozilla (1.7.2) were dying, but nothing in the logs.
>>
>>Please wait for it to happen again, then send the contents of
>>/proc/meminfo, /proc/slabinfo and then do
>>
>>	su
>>	dmesg -c
>>	echo m > /proc/sysrq-trigger
>>	dmesg > foo
>>
>>and send foo as well.

The above was not available (X wouldn't restart), and trying to print 
from any kde app causes the app, and its launcher, to exit.  So I 
don't have a paper copy and my memory isn't photographic, please 
accept my apologies on this.  Maybe rc4 will also do it.  We'll find 
out I guess.  Reboot time again.

[...]

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
