Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276351AbRI1WbE>; Fri, 28 Sep 2001 18:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276350AbRI1Wao>; Fri, 28 Sep 2001 18:30:44 -0400
Received: from host-029.nbc.netcom.ca ([216.123.146.29]:784 "EHLO
	mars.infowave.com") by vger.kernel.org with ESMTP
	id <S276324AbRI1Waj>; Fri, 28 Sep 2001 18:30:39 -0400
Message-ID: <6B90F0170040D41192B100508BD68CA1015A81B6@earth.infowave.com>
From: Alex Cruise <acruise@infowave.com>
To: "'Randy.Dunlap'" <rddunlap@osdlab.org>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: apm suspend broken in 2.4.10
Date: Fri, 28 Sep 2001 15:30:13 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy.Dunlap [mailto:rddunlap@osdlab.org]
 
> > Here's the complete list of modules which might typically 
> > be loaded at boot:
> > [ ad nausaeum ]

> Unload some of these (that you don't really need to run)
> and try "apm -s".
> If that fails, unload some more of them and try again...
> That would at least narrow down the search for us.

I already tried that... Maybe my message didn't get through :)  

>AC> Just for fun, I tried removing all of my loaded 2.4.10 modules one by
one,
>AC> and attempting 'apm --suspend' in between, and still had the same
problem
>AC> when I got down to the bare minimum (ext3 and jbd)

Anyway, it looks like something keyboard- or A20-related is vetoing my
suspend request.  Did you get my "the plot thickens" message?  It's not
appearing in the lkml archives, maybe it got lost last night.

-0xe1a
