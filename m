Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269206AbUJVXU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269206AbUJVXU4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 19:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268447AbUJVXTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 19:19:12 -0400
Received: from h151_115.u.wavenet.pl ([217.79.151.115]:21892 "EHLO
	alpha.polcom.net") by vger.kernel.org with ESMTP id S268455AbUJVXSJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 19:18:09 -0400
Date: Sat, 23 Oct 2004 01:18:03 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The naming wars continue...
In-Reply-To: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.60.0410230104080.32312@alpha.polcom.net>
References: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2004, Linus Torvalds wrote:

>
> Ok,
> Linux-2.6.10-rc1 is out there for your pleasure.
>
> I thought long and hard about the name of this release (*), since one of
> the main complaints about 2.6.9 was the apparently release naming scheme.
>
> Should it be "-rc1"? Or "-pre1" to show it's not really considered release
> quality yet? Or should I make like a rocket scientist, and count _down_
> instead of up? Should I make names based on which day of the week the
> release happened? Questions, questions..
>
> And the fact is, I can't see the point. I'll just call it all "-rcX",
> because I (very obviously) have no clue where the cut-over-point from
> "pre" to "rc" is, or (even more painfully obviously) where it will become
> the final next release.
>
> So to not overtax my poor brain, I'll just call them all -rc releases, and
> hope that developers see them as a sign that there's been stuff merged,
> and we should start calming down and seeing to the merged patches being
> stable soon enough..
[...]
>
> Oh, and the _real_ name did actually change. It's not Zonked Quokka any
> more, that's so yesterday. Today we're Woozy Numbat! Get your order in!
>
> 		Linus
>
> (*) In other words, I had a beer and watched TV. Mmm... Donuts.

So change the naming to something like that:

linux-x.y.z.p

where

x = 2,
y = 6,
z = 1, 3, 5, ... => unstable - something like -rc or -rc-bk
z = 0, 2, 4, ... => stable
p - optional as with 2.6.8.1 - added to stable release when you need to 
correct some very stupid and very important bug,
     added to unstable release - meaning new snapshot


So there will be:
2.6.10 (possibly 2.6.10.1, ... if 2.6.10 will be broken)
2.6.11.0
2.6.11.1
2.6.11.2
...
2.6.12
...


In this scheme you can not mark that you are going to release "stable" 
version quickly, but I do not think we need it. Or if you feel it is 
needed then start numbering p from 90, 91, ... 100, 101, ... for really 
near to stable -rcs.


Grzegorz Kulewski

