Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262716AbSI1Fcr>; Sat, 28 Sep 2002 01:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262723AbSI1Fcq>; Sat, 28 Sep 2002 01:32:46 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:4549 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S262716AbSI1Fcq>;
	Sat, 28 Sep 2002 01:32:46 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200209280537.JAA03046@sex.inr.ac.ru>
Subject: Re: [PATCH] IPv6: Improvement of Source Address Selection
To: pekkas@netcore.fi (Pekka Savola)
Date: Sat, 28 Sep 2002 09:37:33 +0400 (MSD)
Cc: davem@redhat.com, yoshfuji@linux-ipv6.org, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, usagi@linux-ipv6.org
In-Reply-To: <Pine.LNX.4.44.0209280813030.8846-100000@netcore.fi> from "Pekka Savola" at Sep 28, 2 08:24:58 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Or would you have an already-sorted list of possible candidate addresses 
> for each route in the order of preference?

I am not mad yet. :-)

What preference? You must select _one_ address, you do not need lost
candidates.


> And recalculate always when address changes?

What address? Interface address? Routing tables used to be synchronized
to this.


> This is IMO a wrong approach from user's perspective.  Perhaps not if the 
> algorithm was run and e.g. additional, temporary "address selection" 
> routes were created by kernel.
>  
> > > (stuff that's network prefix -independent
> > 
> > I am sorry, I feel I do not understand what you mean.
> 
> Hmm.. this depends on the interpretation of the concept above.  If the
> list is refreshed always when addresses change or change state, this could
> perhaps work..

I am afraid I do not understand what "address", "state", "temporary" routes
etc you mean. It remained in your brains. :-)

Pekka, are you not going to sleep? (I am.) I bet when you reread this tomorrow,
you will not blame that my brains eventually falled to "parse error" loop. :-)

Alexey
