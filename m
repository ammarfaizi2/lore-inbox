Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267275AbTA0SlF>; Mon, 27 Jan 2003 13:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267277AbTA0SlF>; Mon, 27 Jan 2003 13:41:05 -0500
Received: from paloma12.e0k.nbg-hannover.de ([62.181.130.12]:58352 "HELO
	paloma12.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S267275AbTA0SlE> convert rfc822-to-8bit; Mon, 27 Jan 2003 13:41:04 -0500
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Chris Mason <mason@suse.com>
Subject: Re: [PATCH] data logging patches available for 2.4.21-preX
Date: Mon, 27 Jan 2003 19:49:57 +0100
User-Agent: KMail/1.5
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Manuel Krause <manuel.krause@mb.tu-ilmenau.de>
References: <200301271914.26312.Dieter.Nuetzel@hamburg.de> <1043692402.15680.58.camel@tiny.suse.com>
In-Reply-To: <1043692402.15680.58.camel@tiny.suse.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200301271949.57132.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 27. Januar 2003 19:33 schrieb Chris Mason:
> On Mon, 2003-01-27 at 13:14, Dieter Nützel wrote:
> > Hello Chris,
> >
> > as always very nice work!
> > I have it now running fine on top of 2.4.21-pre3-jam3 (2.4.21-pre3aa1).
> > Some fiddling was necessary but went smooth after all.
> > My /home partition is mounted with -o data=ordered and the performance is
> > great. Sorry, no real benchmarks, yet.
>
> Thanks for trying them out.
>
> > But some question stay open:
> > Where is 01-akpm-sync_fs-fix-2.diff
>
> 01-akpm-sync_fs-fix-2.diff is in the 2.4.21 data logging directory you
> linked to below.

It was and I have it but it isn't any longer...
Both 01- are missing, now

> >  and 01-iput-deadlock-fix.diff?
>
> This is in the namesys pending directory, but doesn't apply cleanly
> yet.

OK, you moved it;-)

> I'm rediffing both the quota code and the data logging code on top
> of 01-iput-deadlock-fix (or I might just steal Manuel's rediff, which is
> still in my linuxworld backlog).

Manuel's version (33b) had some trouble with -pre3aa1 (-pre3-jam3), too.

> > Isn't it needed anylonger 'cause you merged them and SuSE's ftp isn't
> > updated yet? All files are the "old" one's from 15. January.
> > ftp://ftp.suse.com/pub/people/mason/patches/data-logging/2.4.21
> >
> > What about patch-2.4.20.rfs.06.05-transaction-overflow-fix-0.diff?
> > Should I put it on top, too?
>
> That is included in 05-data-logging-33.

Nice, no recompile needed then ;-)

I'll do some "normal" vs data=journal/ordered "time synctest -F -f -n 1 -t 100 
dir_name" tests, now.

Maybe I integrate preemption...

-Dieter
