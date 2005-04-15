Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261690AbVDOA37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbVDOA37 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 20:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVDOA1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 20:27:36 -0400
Received: from mail.dif.dk ([193.138.115.101]:21636 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261682AbVDOA06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 20:26:58 -0400
Date: Fri, 15 Apr 2005 02:29:44 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Christian Kujau <evil@g-house.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ALSA Oops (triggered by xmms)
In-Reply-To: <425F07A6.2010402@g-house.de>
Message-ID: <Pine.LNX.4.62.0504150226120.3466@dragon.hyggekrogen.localhost>
References: <425EFB32.2010000@g-house.de> <Pine.LNX.4.62.0504150150240.3466@dragon.hyggekrogen.localhost>
 <425F07A6.2010402@g-house.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Apr 2005, Christian Kujau wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Jesper Juhl wrote:
> > 
> >   ^^^^^ you should send such info inline in the email - having to go check 
> > external links makes a lot of people ignore the stuff right then and 
> 
> yeah, but the oops doesn't wrap at 80 chars itsself and often oopses are
> hardly readable inline.
> 
I would still suggest including the info inline and then if you think it's 
needed /also/ provide the link you did - then you've covered all bases :)

> > Btw: I believe this is fixed in 2.6.11.7 - from the Changelog : 
> >
> > <tiwai@suse.de>
> > 	[PATCH] Fix Oops with ALSA timer event notification
> 
> oh, this sounds good. strange though, that my 2.6.11-gentoo-r5 (whatever
> they've patched in there) *never* oopsed the days ago but all of a sudden
> started to oops yesterday....
> 
Some bugs are like that, especially when they involve race conditions or 
timers.. Anyway, if you could test 2.6.11.7 (and perhaps also 2.6.12-rc*) 
to verify that the issue is indeed fixed, then I believe that would be 
appreciated :)


-- 
Jesper


