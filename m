Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282067AbRKZSub>; Mon, 26 Nov 2001 13:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282055AbRKZStH>; Mon, 26 Nov 2001 13:49:07 -0500
Received: from mail.zabbadoz.net ([195.2.176.194]:62725 "EHLO
	mail.zabbadoz.net") by vger.kernel.org with ESMTP
	id <S282069AbRKZSsO>; Mon, 26 Nov 2001 13:48:14 -0500
Date: Mon, 26 Nov 2001 19:48:12 +0100 (CET)
From: "Bjoern A. Zeeb" <bzeeb+linuxkernel@zabbadoz.net>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Release Policy [was: Linux 2.4.16  ]
In-Reply-To: <Pine.LNX.4.40.0111261216500.88-100000@rc.priv.hereintown.net>
Message-ID: <Pine.BSF.4.30.0111261836000.77704-100000@noc.zabbadoz.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2001, Chris Meadors wrote:

> I like the ISC's release methods.  The do -rc's (-pre's would be fine for
> the kernel as it is already established), each -rc fixes problems found
> with the previous.  When an -rc has been out long enough with no more bug
> reports they release that code, WITHOUT changes.

Hi,

I am neither a vendor nor maintainer nor a great kernel hacker but I
think you all miss at least one point (what I for sure do too):

The problem is that you kernel hackers out there fetch the pre stuff
and test it that others run test cycles on them ... .  But the
lot of people out there will never fetch anything else than
a "release" ; no -pre no -rc no -ac no whatever prefix or suffix.
You will not get them just because somebody 's changing the name
to something else.

Make your test periods longer. If there are no real serious bug in the
pre let the pre live for a week or 2 or even longer. Who cares ? We are in
'stable' branch at the moment! At some (early) point of pre-releases
stop accepting any further features and if the -pre gets real close to being
fine announce that it'll be the last one, make a note to the changelog,
wait another week for seriuos bufixes and then release the tarballs
(or if any have one more pre).

There are for sure some points that there should be better no
more different naming conventions: hpa will surely have to hack up more
scripts, things might get inconsistent between different stable/dev.
versions, we already have the -<some letter> releases for other kernel
hacker's releases like -aa -ac, ... and so on...
But if you really decide on another suffix my vote would be -rc 'cause
it's the most common one (perhaps linus then will use it in the future
too ?)

And always keep in mind: another new 'release' is nothing else than
another 'release candidate' to the next version with hopefully less
bugs more stability (and sometimes more features ;)

just my 5 cents

-- 
Bjoern A. Zeeb				bzeeb at Zabbadoz dot NeT
56 69 73 69 74				http://www.zabbadoz.net/

