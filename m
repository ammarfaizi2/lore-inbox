Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265578AbTAOEav>; Tue, 14 Jan 2003 23:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265661AbTAOEav>; Tue, 14 Jan 2003 23:30:51 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:60852 "EHLO
	mail.kolivas.net") by vger.kernel.org with ESMTP id <S265578AbTAOEat> convert rfc822-to-8bit;
	Tue, 14 Jan 2003 23:30:49 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: Ian Wienand <ianw@gelato.unsw.edu.au>
Subject: Re: [ANNOUNCE] contest benchmark v0.60
Date: Wed, 15 Jan 2003 15:39:34 +1100
User-Agent: KMail/1.4.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Aggelos Economopoulos <aoiko@cc.ece.ntua.gr>
References: <1042500483.3e234b8335def@kolivas.net> <200301151416.54557.conman@kolivas.net> <20030115041524.GE21742@cse.unsw.edu.au>
In-Reply-To: <20030115041524.GE21742@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301151539.36960.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 15 Jan 2003 3:15 pm, Ian Wienand wrote:
> On Wed, Jan 15, 2003 at 02:16:48PM +1100, Con Kolivas wrote:
> > Ok some mildly annoying bugs have already shown up in this release.
> >
> > I've put up a contest-0.61pre on the contest website that addresses the
> > one which ruins the results and has some of the changes going into 0.61
>
> Con/Aggelos,
>
> What was the motivation for re-writing in C?

I believe Aggelos was looking at freebsd compatibility and c was his most 
comfortable language.  Since programming such a thing in c was way beyond my 
capabilities and Aggelos had already taken on the task I was very happy to 
use this as the new codebase. The previous BASH one was getting flakier the 
more I tried to add to it. Also there were subtle things happening in the 
BASH version that made for much more variation in results than this version. 
So it's as much coincidence that Aggelos was writing a new version and I was 
looking for someone to write one that this codebase was chosen for it. 

> I've done some hacking on the old version here, and so I realise that
> such a big shell script was getting a little out of hand, but surely
> perl or python is a better option for this application?

Possibly but clearly c has no major limitations once the hard part (the 
wrapper for the other applications) has been done. 

> If it's going to stay in C maybe we could integrate profiling support
> from /proc/profile, bypassing readprofile?  One of the guys here
> recently wanted to get profiling information from his program, and it
> would have been really good to have a library that could reset, start,
> pause and return in some format the profiling data.  If you think your
> users might be interested in profile outputs I can write something
> maybe we can both use.

I don't know. Anything that may taint the results is bad but I have no idea 
how many confounding variables this really introduces. I need feedback from 
the developers that look at these results to know whether this is worthwhile 
or not. While I'm the said maintainer, contest has grown into a beast of it's 
own.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+JOYHF6dfvkL3i1gRAnY3AJ42aiDcMm1oMhT4fU1c+BhPKzgUGQCfQdu7
KzNQ4kT3OFvOY4dgHPlfAaM=
=so41
-----END PGP SIGNATURE-----
