Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271929AbRHVFUE>; Wed, 22 Aug 2001 01:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271933AbRHVFTz>; Wed, 22 Aug 2001 01:19:55 -0400
Received: from sweetums.bluetronic.net ([24.162.254.3]:60342 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S271930AbRHVFTs>; Wed, 22 Aug 2001 01:19:48 -0400
Date: Wed, 22 Aug 2001 01:19:58 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetopia.net>
X-X-Sender: <jfbeam@sweetums.bluetronic.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Qlogic/FC firmware
In-Reply-To: <E15ZLor-0000cl-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.33.0108220031190.6389-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2001, Alan Cox wrote:
> * 2. Redistribution in binary form must reproduce the above copyright
> *    notice, this list of conditions and the following disclaimer in the
> *    documentation and/or other materials provided with the distribution.
>
>Which is a problem because the kernel is GPL, that isnt GPL compatible
>and until this was pointed out nobody has been going to print their blurb
>in all the manuals - because after all it says GPL.

The kernel source counts as "other materials".

>> Other than it's age, I see *zero* reason to remove it from the tree.
>
>Well let me quote from it again
...
>or in simple terms "might lose all your data"

Gee.  And how many installation have been running that firmware for how
many years without problems?  As I said before, other than it's age, there's
no reason to simply delete it.

>Doesnt work in modules. See previous twice repeated discussion.

We aren't talking about a module when it's compiled into the kernel.  In
the case(s) of modules, there are many ways to provide data (such as
firmware) without the aforementioned bloat everyone wants to bitch about.
And I'd like to point out the people screaming about bloat do not have
the hardware for which this driver is required and thusly will *never*
lose the coveted 128K for it's firmware.  There are areas of "bloat" with
far further reach than this.  Go get a few thousand signatures from actual
Qlogic FC owners running linux oking your destablization of the driver and
I'll leave this alone.  Otherwise, either delete the driver entirely or
put the firmware for which the driver is designed and proven stable by the
test of time back in the tree.

This is the 2.4 "stable" kernel tree.  One would assume people work towards
*increasing* it's stability by fixing its flaws, not wildly deleting shit
and (possibly) randomly breaking things. (But I digress.  I'm treading into
the abyss of source/configuration management of which the kernel tree has
none.)

>As Matthew has noted, we have a source of newer firmware, and because the
>sparc's have this annoying firmware problem it is going to be appropriate
>to add build in firmware as a config option (probably set with def_bool on
>sparc..)

As I recall, the Qlogic ISP driver has had a similar option for years.
(Maybe not to prevent compilation but certainly to prevent loading it.)

>At the time a) I didnt realise the sparc setup was so anal, and b) I didnt
>know about the firmware update.

So basically, you had no fucking clue what kind of instability you were about
to introduce into the current "stable" line of kernels, but did it anyway
simply because of the wording (and your interpretation thereof) of the license
on a firmware "data" file.  Wording that has been unchanged since the day
the file was entered into the tree.  If there were objections, questions,
or other concerns, they should have been raised then and not months or years
later.  And there should have been at least some discussion before removing
the file and seeing who notices. (If I missed this discussion, then I
apologize.)

--Ricky


