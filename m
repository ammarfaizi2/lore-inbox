Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319175AbSHGSsK>; Wed, 7 Aug 2002 14:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319176AbSHGSsK>; Wed, 7 Aug 2002 14:48:10 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:45575
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S319175AbSHGSsJ>; Wed, 7 Aug 2002 14:48:09 -0400
Date: Wed, 7 Aug 2002 11:30:43 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Nick Orlov <nick.orlov@mail.ru>
cc: Bill Davidsen <davidsen@tmr.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pdc20265 problem.
In-Reply-To: <20020807035623.GA3411@nikolas.hn.org>
Message-ID: <Pine.LNX.4.10.10208071127430.15852-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Marcelo,

Well here is the long a waited "I Told You So, but You Would Not Listen".

It worked just fine until you all decided to let an OEM get in the game
and dictate the changes.  Back out the cruft and return sanity to an
insane world.  Just because and OEM makes hardware does not mean they can
make it run proper.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Tue, 6 Aug 2002, Nick Orlov wrote:

> On Tue, Aug 06, 2002 at 11:09:14PM -0400, Bill Davidsen wrote:
> > 
> > > 2. on most hardware, pdc20xxx is really additional controller.
> > 
> > That's the problem, most not all. No matter what we assume it will be
> > wrong part of the time.
> 
> Agreed.
> 
> > 
> > > 3. if we put pdc20265 in "onboard" list on some hardware (mine for example)
> > > pdc20265 is assigned to ide0/1 (even if it's really ide2/3)
> > 
> > Does this matter as long as we can force it to be where we want? 
> 
> But wouldn't it be a cleaner solution if we will have _compile_ time
> option that by default is turned on in order to handle rare cases,
> and _can_ be turned off in order to handle _most_ cases without any
> boot-time options?
> 
> 
> -- 
> With best wishes,
> 	Nick Orlov.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

