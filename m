Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269170AbTCBJVO>; Sun, 2 Mar 2003 04:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269171AbTCBJVO>; Sun, 2 Mar 2003 04:21:14 -0500
Received: from pdbn-d9bb8750.pool.mediaWays.net ([217.187.135.80]:48656 "EHLO
	citd.de") by vger.kernel.org with ESMTP id <S269170AbTCBJVN>;
	Sun, 2 Mar 2003 04:21:13 -0500
Date: Sun, 2 Mar 2003 10:31:26 +0100
From: Matthias Schniedermeyer <ms@citd.de>
To: John Bradford <john@grabjohn.com>
Cc: dank@kegel.com, joe@perches.com, linux-kernel@vger.kernel.org,
       mike@aiinc.ca
Subject: Re: [PATCH] kernel source spellchecker
Message-ID: <20030302093126.GA2772@citd.de>
References: <20030301212537.GA32408@citd.de> <200303020915.h229Fg8G000421@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303020915.h229Fg8G000421@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 02, 2003 at 09:15:42AM +0000, John Bradford wrote:
> > > >This versions defaults to only correct words within a comment. ...
> > > >// Comments are easy(tm). "Everything after // until line-end".
> > > >
> > > >and /* ... */ are easy(tm) too because gcc doesn't support to nest them.
> > > 
> > > I'll be damned.  I'm impressed with how easy that was in perl.
> > 
> > As long as there is no nesting involved most things a easy/trivial to
> > achieve with REs.
> 
> Does it cope with:
> 
> main ()
> {
> // /*
> printf ("hello world");
> // */
> }
> 
> though?

No. I could fix this, but i don't think it's worth it.




Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

