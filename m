Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276344AbRI1WeQ>; Fri, 28 Sep 2001 18:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276355AbRI1WeF>; Fri, 28 Sep 2001 18:34:05 -0400
Received: from air-1.osdlab.org ([65.201.151.5]:27657 "EHLO
	osdlab.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S276353AbRI1Wdw>; Fri, 28 Sep 2001 18:33:52 -0400
Message-ID: <3BB4FA41.DAAFB705@osdlab.org>
Date: Fri, 28 Sep 2001 15:31:29 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alex Cruise <acruise@infowave.com>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: apm suspend broken in 2.4.10
In-Reply-To: <6B90F0170040D41192B100508BD68CA1015A81B6@earth.infowave.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Unload some of these (that you don't really need to run)
> > and try "apm -s".
> > If that fails, unload some more of them and try again...
> > That would at least narrow down the search for us.
> 
> I already tried that... Maybe my message didn't get through :)
> 
> >AC> Just for fun, I tried removing all of my loaded 2.4.10 modules one by
> one,
> >AC> and attempting 'apm --suspend' in between, and still had the same
> problem
> >AC> when I got down to the bare minimum (ext3 and jbd)
> 
> Anyway, it looks like something keyboard- or A20-related is vetoing my
> suspend request.  Did you get my "the plot thickens" message?  It's not
> appearing in the lkml archives, maybe it got lost last night.

I saw the keyboard message, and someone else's A20 reference.
Not one from you IIRC.

~Randy
