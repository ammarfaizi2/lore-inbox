Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWH3KHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWH3KHW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 06:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWH3KHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 06:07:22 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:19243 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750767AbWH3KHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 06:07:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PzRt2AqvAwxj/HdQWFLJXeHeCmgca9C6JPOZeBwR5Hfc1tnJd/pZp7dtWE/KvfM/ioeqix4N6oloPqa6MRJsoEdgYpTwMEWNp6bopp+AxBZvnpqlq3sYyb0I6cKnQhyITEtc6xeOrs7Jdfjbz954If2xKs4W3fJs8t4LGF5Av1A=
Message-ID: <742b1fb30608300307q750c45f8t9c81435d5bd98adb@mail.gmail.com>
Date: Wed, 30 Aug 2006 12:07:18 +0200
From: "Patrizio Bassi" <patrizio.bassi@gmail.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [BUG?] 2.6.17.x suspend problems
Cc: linux-kernel@vger.kernel.org, "Pavel Machek" <pavel@ucw.cz>
In-Reply-To: <742b1fb30608300208g487ab973yb2b326a01820e94c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <742b1fb30608280446x2b0cf2d4p5aae2bb66ba41555@mail.gmail.com>
	 <742b1fb30608290414w5d7efc2et349f5ca32f241834@mail.gmail.com>
	 <742b1fb30608292358y6cebdf4eg654d7a1973a91c3@mail.gmail.com>
	 <200608301101.01816.rjw@sisk.pl>
	 <742b1fb30608300208g487ab973yb2b326a01820e94c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/8/30, Patrizio Bassi <patrizio.bassi@gmail.com>:
> 2006/8/30, Rafael J. Wysocki <rjw@sisk.pl>:
> > On Wednesday 30 August 2006 08:58, Patrizio Bassi wrote:
> > > 2006/8/29, Patrizio Bassi <patrizio.bassi@gmail.com>:
> > > > 2006/8/29, Rafael J. Wysocki <rjw@sisk.pl>:
> > > > > On Monday 28 August 2006 13:46, Patrizio Bassi wrote:
> > > > > > when i try to suspend my notebook i have problems with ide controller.
> > > > > > the copy lasts a lot and i get oops.
> > > > >
> > > > > I haven't seen any patches related to SIS chipsets recently.
> > > > >
> > > > > There is a chance the latest -mm will work, so you can try it (no warranty,
> > > > > though).  If not, please file a bug report at http://bugzilla.kernel.org
> > > > > (with a Cc to rjwysocki@sisk.pl).
> > > >
> > > >
> > > > do you mean the .18-mm sources i guess, not the .17 ones.
> > > >
> > > > Ok, i'll try as soon as possibile.
> >
> > ]--snip--[
> > > i just tested 2.6.18-rc4-mm3.
> > >
> > > as soon as i ask for suspending i get a black screen.
> > > waiting for lots of time...something like 1 min i see:
> > >
> > > Disabling Interrupt #14
> > > and after, even waiting some means...nothing more.
> >
> > Please file a report at http://bugzilla.kernel.org like I said previously.
> >
> > I'm afraid there's no quick fix for you right now.
> >
> > Greetings,
> > Rafael
> >
> >
>
> i'll fill a bug, but i feel that synaptics bug may be the blocking problem.
> Maybe fixing that (same problem in .17 sources too) may "unlock" the
> suspending procedure too.
>
> Some work for input team so. ihmo.
>
> Thanks
>
>

just opened

http://bugzilla.kernel.org/show_bug.cgi?id=7077

Bye


-- 

Patrizio Bassi
www.patriziobassi.it
