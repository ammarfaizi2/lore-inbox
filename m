Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262570AbVAEU4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262570AbVAEU4o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 15:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262585AbVAEU4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 15:56:44 -0500
Received: from alog0237.analogic.com ([208.224.220.252]:8320 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262570AbVAEU40
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 15:56:26 -0500
Date: Wed, 5 Jan 2005 15:48:46 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: lsorense@csclub.uwaterloo.ca
cc: prism54-devel@prism54.org, prism54-users@prism54.org,
       Netdev <netdev@oss.sgi.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>
Subject: Re: Open hardware wireless cards
In-Reply-To: <20050105201434.GB30311@csclub.uwaterloo.ca>
Message-ID: <Pine.LNX.4.61.0501051533470.12237@chaos.analogic.com>
References: <20050105192447.GJ5159@ruslug.rutgers.edu>
 <20050105200526.GL5159@ruslug.rutgers.edu> <20050105201434.GB30311@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jan 2005 lsorense@csclub.uwaterloo.ca wrote:

> On Wed, Jan 05, 2005 at 03:05:26PM -0500, Luis R. Rodriguez wrote:
>> I'd also like to add...
>>
>> For those of you frustrated about our current wireless driver situation
>> in open platforms --
>>
>> I think we probably will have this trouble with most modern hardware for a while
>> (graphics cards, wireless driver, etc). A lot of has to do with patent
>> infringement issues, "intellectual property" protection, and other
>> business-oriented excuses.
>>
>> What I think we probably will have to do is just work torwards seeing if
>> we can come up with our own open wireless hardware. I know there was
>> a recent thread on lkml about an open video card -- anyone know where
>> that ended up?
>>
>> If we can't come up with our own project to work on open hardware we can
>> also just see if its feasible to purchase hardware companies on the
>> verge of going backrupt and buy them out and release the specs/etc (a la
>> blender). Can someone do the math here? I'm lazy.
>
> Being open doesn't mean you aren't violating some stupid patent.
> Software patents really are an incredibly stupid idea.  Algorithms are
> pushing it.  After all what does the algorithm do on it's own?  Can you
> show it working and doing something?
>
> Len Sorensen

Well its mostly about making boards just a bit too cheap.

If the vendors would just put in a serial EPROM that loads the
proprietary stuff to their PLD upon startup, then there is
no "proprietary" code to worry about. You have the generic
published interface like a PLX chip, plus the specific published
register functions of their PLD chip. How the device actually
makes smoke and mirrors is hidden even from the programmer.

But, by eliminating the US$0.50 cost of a EPROM, they want to supply
a sack of bits that needs to be uploaded to the PLD by software. This
sack of bits can be reverse-engineered so companies are not going
to supply these (you can extract those bits from a Win-Modem dll so
this gets a bit too ridiculous for some devices).

In most cases it's not some algorithm that needs to be protected.
Instead its the 400-or-so engineering man-hours used to develop the
contents of the PLD (notice I did not use the words "Gate-Arrays"
until now. There are many kinds of Programmable Logic Devices).

Until vendors stop being penny-wise-pound-foolish, we will continue
to have these kinds of problems. Vendor education will ultimately
be the fix, I predict.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
