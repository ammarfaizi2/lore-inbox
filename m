Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261943AbSI3HRF>; Mon, 30 Sep 2002 03:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261944AbSI3HRF>; Mon, 30 Sep 2002 03:17:05 -0400
Received: from packet.digeo.com ([12.110.80.53]:56240 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261943AbSI3HRE>;
	Mon, 30 Sep 2002 03:17:04 -0400
Message-ID: <3D97FB9C.593849A9@digeo.com>
Date: Mon, 30 Sep 2002 00:22:04 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.38 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Clark <michael@metaparadigm.com>
CC: Matthias Andree <matthias.andree@gmx.de>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@codemonkey.org.uk>, Jens Axboe <axboe@suse.de>,
       "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: v2.6 vs v3.0
References: <200209290114.15994.jdickens@ameritech.net> <Pine.LNX.4.44.0209290858170.22404-100000@innerfire.net> <20020929134620.GD2153@gallifrey> <20020929154254.GD1014@suse.de> <20020929162221.GB19948@suse.de> <20020929214652.GF12928@merlin.emma.line.org> <3D97F7AE.5070304@metaparadigm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Sep 2002 07:22:09.0435 (UTC) FILETIME=[168706B0:01C26852]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Clark wrote:
> 
> On 09/30/02 05:46, Matthias Andree wrote:
> > On Sun, 29 Sep 2002, Dave Jones wrote:
> >
> >
> >>Joe Thornber sent a patch removing LVM1, but LVM2 has yet to
> >>make an appearance in 2.5.x patchform afair.  LVM is in one of
> >>those sneaky positions where they could theoretically cheat
> >>the feature freeze, as whats in the tree right now is fubar,
> >>and we need /something/ before going 2.6/3.0.
> >
> >
> > Is not EVMS ready for the show? Is Linux >=2.6 going to have LVM2 and
> > EVMS? Or just LVM2? I'm not aware of the current status, but I do recall
> > having seen EVMS stable announcements (but not sure about 2.5 status).
> 
>  From reading the EVMS list, it was working with 2.5.36 a couple weeks
> ago but needs some small bio and gendisk changes to work in 2.5.39.
> 

It's going to break bigtime if someone ups and removes all the
kiobuf code.....
