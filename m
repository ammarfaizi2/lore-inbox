Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261438AbTCQJgB>; Mon, 17 Mar 2003 04:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261458AbTCQJgB>; Mon, 17 Mar 2003 04:36:01 -0500
Received: from poup.poupinou.org ([195.101.94.96]:17412 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP
	id <S261438AbTCQJgA>; Mon, 17 Mar 2003 04:36:00 -0500
Date: Mon, 17 Mar 2003 10:46:51 +0100
To: Valdis.Kletnieks@vt.edu
Cc: Ducrot Bruno <poup@poupinou.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.5 XFree and nvidia geforce.
Message-ID: <20030317094651.GB8814@poup.poupinou.org>
References: <3E70086B.6080408@lemur.sytes.net> <20030313201624.GA29107@suse.de> <Pine.LNX.4.51.0303132026210.24455@dns.toxicfilms.tv> <20030313231615.07563914.bonganilinux@mweb.co.za> <200303132155.h2DLtsRU015899@turing-police.cc.vt.edu> <20030314194050.GA8814@poup.poupinou.org> <200303142244.h2EMi0b4025022@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303142244.h2EMi0b4025022@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4i
From: Ducrot Bruno <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 14, 2003 at 05:44:00PM -0500, Valdis.Kletnieks@vt.edu wrote:
> On Fri, 14 Mar 2003 20:40:50 +0100, Ducrot Bruno said:
> 
> > One of the main issue for me (I don't want flame please) is
> > that it kill acpi and/or apm.  Since it's more important for
> > for me to get suspension working, I can not use any
> >  drivers provided by nVidia unless of course they implement
> 
> No flames intended - I just have different requirements than you do,
> and suspending hasn't been an issue for me, and I've not bothered
> trying to get it to work.
> 
> I've seen a workaround posted for the nvidia suspend issue - the trick was to
> configure a suspend script that apmd/whatever would call, and include
> a '/usr/bin/chvt 1' in it.  So on the way down, it would change off the
> nvidia-controlled VT, and all would be well.

No.  I spoke for a missing function in the binary part (was present
in 15.., but removed in 20.. and 28..) )...

> 
> > BTW, XFree4.3.0 is out, and your GeForce is supported.
> 
> Oh, the free driver has "supported" the card for ages.  My point was that (a)
> the free driver isn't 2-d accelerated as much as the NVidia driver (the 'nv'
> free driver can average 10-15% CPU by itself, and the 'nvidia' closed driver
> only 1-2% while feeling much quicker), and (b) the NVidia driver "just works"
> in finding the video port on the docking station when I'm docked - the 'nv'
> free drivers would find the LCD screen fine and not find the docking port
> video.

... and seem that this function is now reintroduced in the lasted
release in the nvidia binary.  I guess that more work has to be
done, though, but I consider that my really lastest complain
about the binary driver from nvidia go now to /dev/null.

Cheers,


-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page
