Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129664AbRAWS1h>; Tue, 23 Jan 2001 13:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129759AbRAWS13>; Tue, 23 Jan 2001 13:27:29 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:45829 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129664AbRAWS1T>; Tue, 23 Jan 2001 13:27:19 -0500
Date: Tue, 23 Jan 2001 13:28:38 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: "Trever L. Adams" <trever_Adams@bigfoot.com>
cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Total loss with 2.4.0 (release)
In-Reply-To: <3A6D56EE.2070003@bigfoot.com>
Message-ID: <Pine.LNX.4.32.0101231315500.7610-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jan 2001, Trever L. Adams wrote:

>> I don't see how Windows 9x can be at fault in any way shape or
>> form, if you can boot between 2.2.x kernel and 9x no problem, but
>> lose your disk if you boot Win98 and then 2.3.x/2.4.x and lose
>> everything.  Windows does not touch your Linux fs's, so if there
>> is a problem, it most likely is a kernel bug of some kind that
>> doesn't initialize something properly.
>
>Well, I boot into Linux, all is fine, rebooted into a different version
>of Linux for some testing, all is fine (this was an older version, I
>believe it was 2.2.14 or .15)  Try to install ME and run it, seems ok.
>Go back to Linux, and my drive was fried with Windows files all over it,
>etc.

Ahh.  Now _that_ is different.  ;o)  In this case, yes Windows
sucks.  I retract my comment entirely.  ;o)  At least I was
trying to be fair and unbiased, (despite being very biased
in favor of Linux by a factor of about 10^99999999999). ;op


>I know Windows shouldn't touch a Linux partition.  But, apparently it
>did.  Or else Linux and/or Fdisk are fried and made a bad partition table.

Whwnever you install/upgrade any OS and especially M$ ones on a
multiboot machine, you should always ensure ahead of time that
they will play nicely together, agree on geometry translation
schemes, partitioning schemes, etc, and that any option to take
over the whole machine is turned off.  Windows NT defaults to
"fry the whole disk", but I don't know about ME or W2K as they
are IMHO just bloat + new pictures, etc..

I know if you have a 8G drive or larger, and install NT4 on it it
will fry everything entirely unless you stand on your head and
read about 50 MS kb articles.  Thankfully, I will _never_ have to
encounter this sort of thing again though.  ;o)


>> Windows sucks, and I hate it as much (probably more) than the
>> next guy.  It's not fair to blame every computer problem on it
>> though unless you KNOW that Windows directly caused the problem.
>
>I said what I did, because it seems the evidence said Windows did do it.
>If it didn't, oops.  I have talked with others and they had a similar
>experience, so I am not alone.

Right, sounds like you are correct.  I thought you had Windows
installed already, and were merely booting between the two and
then lost everything.  That is an unlikely scenario to occur
though..  Installing WinXY is a different story though.  ;o)


>> Pick one of the 1000000000 good reasons to say Windows sucks
>> instead...
>>
>> For what it is worth, I have a similar problem where if I boot
>> Windows (to show people what "multicrashing" is), if I boot back
>> into Linux, my network card no longer works (via-rhine).  Most
>> definitely a Linux bug.  In this case, "via-rhine.o" sucks.
>>
>> ;o)
>
>Well, this is actually the second time I have had Windows write all over
>my Linux partition.  The first time I think it was not a bug in either,
>but a bug in hardware.  However, I no longer have that hardware as my
>desktop.

If it occurs frequently, I would double or triple check the BIOS
configuration of your drives, as well as the way that Linux sees
them.  Such a problem should be quite rare if it is all set up
right - barring viruses, trojans, and script kiddies.

Is it possible that the kernel you're using is messed up, and
doesn't umount the disks properly?  Perhaps some silent disk
corruption issue?  Does fdisk show only a single partition the
size of your whole disk, or are Linux partitions still in
existance.  I would wager that if linux partitions show up in the
partition table, that there is a good chance Windows didn't screw
it up.  I won't bank on that though, as Windows can certainly
foob things in many ways.  ;o)

Good luck.

TTYL

----------------------------------------------------------------------
    Mike A. Harris  -  Linux advocate  -  Free Software advocate
          This message is copyright 2001, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------
"Facts do not cease to exist because they are ignored."
                                               - Aldous Huxley

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
