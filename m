Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268990AbTCATJP>; Sat, 1 Mar 2003 14:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268998AbTCATJP>; Sat, 1 Mar 2003 14:09:15 -0500
Received: from virtisp1.zianet.com ([216.234.192.105]:51728 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S268990AbTCATJO>; Sat, 1 Mar 2003 14:09:14 -0500
Subject: Re: [PATCH] kernel source spellchecker
From: Steven Cole <elenstev@mesatop.com>
To: Dan Kegel <dank@kegel.com>
Cc: Matthias Schniedermeyer <ms@citd.de>, Joe Perches <joe@perches.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mike@aiinc.ca
In-Reply-To: <3E6101DE.5060301@kegel.com>
References: <Pine.LNX.4.44.0303011503590.29947-101000@korben.citd.de> 
	<3E6101DE.5060301@kegel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 01 Mar 2003 12:18:23 -0700
Message-Id: <1046546305.10138.415.camel@spc1.mesatop.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-01 at 11:54, Dan Kegel wrote:

> 
> I suggest we remove the entries
>   broken=borken
>   brain-damaged=dain-bramaged,dain bramaged
> as we're not trying to remove humor from the comments.
> 
> Also, the words 'controllen' and 'callin',  are not typos, so
>   calling=callin
> should be removed, and
>   controller=controler,controllen
> should be just
>   controller=controler
> 
> The above examples make me think the list of corrections will have
> to be very carefully vetted before we turn this thing loose.
> - Dan

Once you've loosed your beast upon the tree, I'd suggest that you
very carefully look through the resulting diff for inappropriate
corrections and redact the unnecessary hunks.  In the spelling fixes
which I sent to Linus, I redacted hunks which didn't need fixing.  For
example, Linus making fun of Sun folks' ability to spell, etc. and some
comments in French or German for which the spelling was correct in those
languages.

In addition to making fixes in the comments in the source, all of
Documentation should be fair game.

Then you'll have to contend with the folks whose out-of-tree patches
you've borked.

Steven

