Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <153860-31090>; Mon, 14 Dec 1998 08:08:14 -0500
Received: from tigra-eth0.gu.net ([194.93.191.131]:3846 "EHLO tigra.gu.net" ident: "ksi") by vger.rutgers.edu with ESMTP id <154509-31090>; Mon, 14 Dec 1998 06:57:16 -0500
Date: Mon, 14 Dec 1998 14:22:49 +0200 (EET)
From: Serguei Koubouchine <ksi@gu.net>
To: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.rutgers.edu
Subject: Re: ARRGHH !!! Gated is broken again in 2.1.131 ...
In-Reply-To: <Pine.LNX.3.96.981213125057.15918B-100000@filesrv1.baby-dragons.com>
Message-ID: <Pine.LNX.4.05.KSI2.9812141405160.24610-100000@tigra.gu.net>
X-FTN-PID: Pine-3.96.KSI
X-FTN-Tearline: Pine-3.96.KSI (KSI Linux)
X-FTN-Origin: -= KSI's Nest =- Kiev Ukraine (2:463/400)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

On Sun, 13 Dec 1998, Mr. James W. Laferriere wrote:

> 
> 	Hello Serguei,
> 
> On Sun, 13 Dec 1998, Serguei Koubouchine wrote:
> > On Sat, 12 Dec 1998, Mr. James W. Laferriere wrote:
> > > > It is not 2.1 specific, I saw and fixed this bug in early 1.3 (or
> >even 1.1?
> > > > I do not remember, it was years ago), when RTF_REJECT appeared.
> > > > 
> > > > As I understood the case with OSPF is closed. OK.
> > > 	You mean the one reported by Serguei Koubouchine ?
> > 
> > Yes, gated DOES work again (2.1.131-ac10 + modified kernel-ss981207.dif.gz,
> > gated-3.5.10 + patches).                            ^^^^^^^^^^^^^^^ 2)
>                  ^^^^^^^ 1) Which patches ?, Could you give an URL ?
> 	Or are these something you have put together ?
> 	Could you post or place for ftp these ? (1 & 2)

I do make the localized Linux distribution (KSI Linux) for use primarily in
ex-USSR (the right locales, cyrilization out of the box etc.). The about to
be released version 2.0 (Nostromo) is kinda different from every
distribution on the market now - it's built around 2.1.xxx and includes
almost all networking staff from Alexey (we DO use traffic control with CBQ
rather extensively in a production environment). You can find RPMs and SRPMs
on ftp://ftp.ksi-linux.com/pub/Devel/Nostromo (the directory is a little bit
outdated, I'll sync it with the main tree tomorrow). If you do not have (or
do not like) RPM for some reason, you can find the patches extracted from
SRPMs at ftp://ftp.ksi-linux.com/pub/patches.

> 	2) Hmmm, that almost looks like one of Alexey's filenames but I
> 	can't find a file on his site of that name . Tia

Yes, it's the Alexey's 981206 updated to apply cleanly against ac kernels.
The latest one is kernel-ss981212.dif.gz made against 2.1.131-ac10 (fits
nicely into ac-11). You can find it in the patches directory too.

=======================================================================
Serguei Koubouchine aka the Tamer < > The impossible we do immediately.
e-mail: ksi@gu.net   SK320-RIPE   < > Miracles require 24-hour notice.
=======================================================================


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
