Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272003AbRHVN3u>; Wed, 22 Aug 2001 09:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271641AbRHVN3k>; Wed, 22 Aug 2001 09:29:40 -0400
Received: from sweetums.bluetronic.net ([24.162.254.3]:37817 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S272002AbRHVN32>; Wed, 22 Aug 2001 09:29:28 -0400
Date: Wed, 22 Aug 2001 09:29:38 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetopia.net>
X-X-Sender: <jfbeam@sweetums.bluetronic.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Qlogic/FC firmware
In-Reply-To: <E15ZVJL-0001HR-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.33.0108220844500.6389-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2001, Alan Cox wrote:
>Like loading it from user space. Which is exactly the same code needed
>for an initrd. Amazing isn it.

Amazing *and* unnecessarily complex.  What a bargin!  And it's still going
to consume that precious 128K even when loaded from usersapce as the driver
will still need to keep it.  And aren't you one of the Preists of Text in
/proc -- those of the belief in managing everything with 'cat' and 'vi'.

>Wrong. I object to wasting 128K and I have fibrechannel. Its that kind of
>sloppy "who cares about 128K" thinking that leads to several megs
>disappearing and your OS turning into sludge.

Way too damn late make that argument.  That snowball has been gaining mass
and speed for years now.  I would not recommend standing in front of it.

>> So basically, you had no fucking clue what kind of instability you were about
>> to introduce into the current "stable" line of kernels, but did it anyway
>
>It caused a trivial little problem for a few sparc people which basically has
>only been more than a
>
>	"Hey Alan, sparc needs firmware compiled in can you fix"
>
>because it seems you have to be arrogant and opinionated to own a sparc64
>box 8)

I stand by my original "fucking" comment :-)  I wouldn't trivialize this
"little problem".  I'm guessing this is a problem for Alphas as well.  Altho'
Digital (now Compaq) doesn't call it a Qlogic,FC -- their naming scheme is
on par with Cisco -- it doesn't have any firmware on the card.  SRM loads
firmware on it to scan for devices.  Having a machine randomly crash for no
easily detectable reason (esp. if you log to FC) is not good.  In fact,
one may not notice the problem for some time.

Dave, what kind of messages does a master abort cause?

>> the file was entered into the tree.  If there were objections, questions,
>> or other concerns, they should have been raised then and not months or years
>> later.  And there should have been at least some discussion before removing
>
>Take that one up with Linus. I didn't merge it originally

No, you take it up with Linus (and the Qlogic maintainer) as you are the nut
removing it ... and introducing a great big question mark around the stability
of the Qlogic FC driver.

--Ricky


