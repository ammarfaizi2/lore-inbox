Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318919AbSICUvj>; Tue, 3 Sep 2002 16:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318923AbSICUvi>; Tue, 3 Sep 2002 16:51:38 -0400
Received: from pD9E23EAA.dip.t-dialin.net ([217.226.62.170]:53889 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318919AbSICUvh>; Tue, 3 Sep 2002 16:51:37 -0400
Date: Tue, 3 Sep 2002 14:55:52 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Hacksaw <hacksaw@hacksaw.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH - change to blkdev->queue calling triggers BUG in md.c
In-Reply-To: <1031085908.21439.17.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0209031448000.3373-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3 Sep 2002, Alan Cox wrote:
> And what about all the firmware that needs PC partition tables ?

As mentioned, they should really consider going away. It's currently a bit 
crappy all over, but we might learn from that.

> They won't be going away in a hurry

Not too quickly, but they will. Maybe even before the apocalypse.

> > You can't get that with partition tables either. And by the way, we 
> > succeeded doing that at Magdeburg. Pull out the power supply, batteries, 
> > etc., then run away.
> 
> Why not - you can journal partition updates too. There are systems out
> there that do it, even ones that do cluster safe partition management on
> the fly.

That didn't help when they told us the water would come. We've put the 
disks into bags and unplugged the supply.

And if you meant why not use journaled partition updates on raid -- I 
still don't see how this could be any good without complicating things. 
Maybe you can enlighten me?

> If you want to do partitions in user space and play with the idea the
> LVM2 code is very clean, very nice and already provides you with
> everything needed to do it nicely.

LVM2 is not the kind of thing I'd want to use on my big bad mainframe. It 
may be feasible, but it doesn't have that smell. And where to plug all 
those disks?

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

