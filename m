Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287149AbRL2G7a>; Sat, 29 Dec 2001 01:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287148AbRL2G7V>; Sat, 29 Dec 2001 01:59:21 -0500
Received: from white.pocketinet.com ([12.17.167.5]:59018 "EHLO
	white.pocketinet.com") by vger.kernel.org with ESMTP
	id <S287145AbRL2G7H>; Sat, 29 Dec 2001 01:59:07 -0500
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <nknight@pocketinet.com>
Reply-To: nknight@pocketinet.com
To: Keith Owens <kaos@ocs.com.au>, Mike Castle <dalgoda@ix.netcom.com>
Subject: Re: State of the new config & build system
Date: Fri, 28 Dec 2001 22:59:15 -0800
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9467.1009601050@ocs3.intra.ocs.com.au>
In-Reply-To: <9467.1009601050@ocs3.intra.ocs.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <WHITELXfKCzxg8cL3zb00000801@white.pocketinet.com>
X-OriginalArrivalTime: 29 Dec 2001 06:57:31.0300 (UTC) FILETIME=[15E44640:01C19036]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 December 2001 08:44 pm, Keith Owens wrote:
> On Fri, 28 Dec 2001 20:21:39 -0800,
>
> Mike Castle <dalgoda@ix.netcom.com> wrote:
> >On Fri, Dec 28, 2001 at 10:58:03PM -0500, Legacy Fishtank wrote:
> >> s/break/update dependencies/
> >>
> >> I assumed this was blindingly obvious, but I guess not.
> >
> >To YOU and other kernel hackers, yes.
> >
> >But not to everyone.
> >
> >Plus, as I understand it, it will be faster to:
> >
> >apply a patch and rebuild with kbuild 2.5
> >
> >than to:
> >
> >apply a patch, make dep && make bzImage.
> >
> >Correct?
>
> As long as the patch does not change an include file that is used a
> lot, yes, a patch and make will be significantly faster using kbuild
> 2.5.
>
> What Mr. Fishtank seems to overlook is that kbuild 2.5 is far more
> flexible and accurate than 2.4, including features that lots of
> people want, like separate source and object trees.  Now that the
> overall kbuild design is correct, the core code can be rewritten for
> speed. And that will be done a couple of weeks after kbuild 2.5 goes
> into the kernel, then I expect kbuild 2.5 to be faster than kbuild
> 2.4 even on full builds.
>

What, exactly, is the point of merging something that nobody is going 
to use unless they want to test it, in which case they can grab a patch 
from somewhere?
It's half the speed of the current system. The current system works, no 
matter how horrible its internals can be. That makes the NEW system 
BROKEN. If it's KNOWN to be BROKEN prior to merge then it shouldn't 
even be in a 2.5.*-pre#.

kbuild 2.4 works, but it's ugly! Let's create a new system!
You mean the new system is half the speed but it's more attractive? 
Well I guess we'll go with the new system anyway!

(sound familier?:
Oh look at this new processor with all this fancy shit from <company 
name withheld>! It even scales to absurdly high Mhz numbers!
Let's all spend a ton of money to get it!
Oh wait, you mean this old processor that costs nothing compared to the 
new one outperforms this new one? Oh well, let's get the new one anway!)

