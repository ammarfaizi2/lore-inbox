Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292377AbSBBUHJ>; Sat, 2 Feb 2002 15:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292376AbSBBUHA>; Sat, 2 Feb 2002 15:07:00 -0500
Received: from femail38.sdc1.sfba.home.com ([24.254.60.32]:444 "EHLO
	femail38.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S292370AbSBBUGu>; Sat, 2 Feb 2002 15:06:50 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: Bitkeeper change granularity (was Re: A modest proposal -- We need a patch penguin)
Date: Sat, 2 Feb 2002 15:07:56 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0202021302430.17850-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0202021302430.17850-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020202200647.HWIG4921.femail38.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 02 February 2002 10:03 am, Rik van Riel wrote:

> Are you really this much of a lazy bum that you prefer
> badmouthing Larry over searching bitkeeper.com for five
> minutes and grabbing the bitkeeper source ? ;)

Actually, I got as far as the questionaire and mailback to get the 
registration required to download anything from bitmoover before putting it 
on my "to do" list, and went and looked at the online docs instead.  (I move 
back to Austin soon, I'm kind of swamped...)

I honestly didn't know the source was available.  I vaguely remembered that 
if bitkeeper were to go out of business the source code would become 
available (under the GPL) after a few months, which kind of implied that 
wasn't the case now.

As for bitkeeper's website, it doesn't mention source code on the main page, 
it doesn't mention any so on the downloads page or the questionaire following 
it, the "free software" link from the downloads page mentions lmbench, 
bitcluster, and webroff but -not- bitkeeper, and the reference manual doesn't 
have a mention of source code (if it does, I missed it) until you get to the 
licensing page (documention->reference manual->licensing) which has "the 
bitkeeper license" that says portions of it (two libraries and the installer) 
are available as GPL code, but the rest would only be released as GPL 180 
days after bitkeeper goes out of businesss).

That actually took a little more than five minutes.  They I went and did 
something else... :)

Looking at the license again, section 2B does seem to imply it's possible to 
get non-GPL source code from bitmover (although it doesn't say it's not 
purchased source code).

But looking looking at the license again, this section under "licensee 
obligations" is certainly interesting:

>     (a)   Maintaining Open Logging Feature: You hereby warrant
>             that you will not take any action to disable or oth-
>             erwise interfere with the Open  Logging  feature  of
>             the BitKeeper Software.  You hereby warrant that you
>             will take any necessary actions to ensure  that  the
>             BitKeeper  Software successfully transmits the Meta-
>             data to an Open Logging server within  72  hours  of
>             the  creation of said Metadata.  By transmitting the
>             Metadata to an Open Logging server, You hereby grant
>             BitMover,  or  any other operator of an Open Logging
>             server, permission to republish the Metadata sent by
>             the BitKeeper Software to the Open Logging server.

Meaning if I use my laptop offline for more than three days, I could be in 
violation of the bitkeeper license.  And under section 4.2, you can pay to 
have that requirement removed.

Section 3C also mentions there's ANOTHER license included in the download (a 
sort of terms of use) which, if you don't comply with it, seems to imply your 
access to bitkeeper's public servers could be revoked...  (How does this 
interact with the "bitkeeper must be able to log your activities" 
requirement?  I don't think I want to know...)

I think I'll stick with diff/patch/rcs for now, thanks.

> regards,
>
> Rik

Rob
