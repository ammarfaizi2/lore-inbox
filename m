Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319171AbSHGSfj>; Wed, 7 Aug 2002 14:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319172AbSHGSfi>; Wed, 7 Aug 2002 14:35:38 -0400
Received: from h-64-105-137-214.SNVACAID.covad.net ([64.105.137.214]:19585
	"EHLO freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S319171AbSHGSfg>; Wed, 7 Aug 2002 14:35:36 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 7 Aug 2002 11:39:04 -0700
Message-Id: <200208071839.LAA08673@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pdc20265 problem.
Cc: alan@lxorguk.ukuu.org.uk, thunger@ngforever.de, vandrove@vc.cvut.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-07 at 10:47, Alan Cox wrote:
>On Wed, 2002-08-07 at 08:54, Adam J. Richter wrote:
>>       Linux users in the "I'm not a sysadmin" crowd (?) probably
>> don't care about the scan order of the pdc20265 IDE controller,
>> but people in the "I'm a sysadmin, not a programmer" crowd
>> may have legitimiate reasons to.
>
>The non sysadmin people care that is has not change, and generally
>prefer that its the same ordering as windows seems to use. Once you go
>to modular IDE it gets trickier. Certainly if you load modules the usual
>bets are off (as with scsi)
[...]

And Petr Vandrovec wrote:
| But such "I'm not a sysadmin" people will be very surprised that their
| promise was IDE2 in 2.2.x, it was IDE2 in 2.4.18, it is IDE2 in 2.5.30,
| and now - oops - it is IDE0 in 2.4.19. Broken, I'd say.

	I was not expresing an opinion on what the default
ordering should be.

	There seemed to be agreement that no single ordering would
make all users happy and that there should be some way of changing
the ordering.  The post that I replied to discussed and module
arguments versus a compile time flag.  All that I was saying was
that providing arguments would probably be more useful for the
population that might care about this issue, as they might not be
comfortable having to rebuild custom kernels (or supporting another
kernel in their site, I should add now).

I might as well address the response from "Thunder from the hill" as well;
: Oh, that's really no problem. You can reduce the programm to choosing a 
: simple list entry and clicking a button. Anything can be made easy via the 
: proper frontend. (And BTW, one should always be both - (sys|net)admin and 
: "programmer".)

	That would require the distribution provider to double
the number of precompiled kernels or module trees that they ship
and support.  That would be a lot more work than implementing a
module option and a boot option and use a lot more space, for no
substatial advantages that I'm aware of.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
