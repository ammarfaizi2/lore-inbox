Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751734AbWIBXOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734AbWIBXOA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 19:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbWIBXOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 19:14:00 -0400
Received: from rrcs-24-227-114-150.se.biz.rr.com ([24.227.114.150]:55948 "EHLO
	sleekfreak.ath.cx") by vger.kernel.org with ESMTP id S1751733AbWIBXN7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 19:13:59 -0400
Date: Sat, 2 Sep 2006 19:11:52 -0400 (EDT)
From: shogunx <shogunx@sleekfreak.ath.cx>
To: Matthias Hentges <oe@hentges.net>
cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       Stephen Hemminger <shemminger@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: sky2 hangs on me again: This time 200 kb/s IPv4 traffic, not
 easily reproducable
In-Reply-To: <1157233344.18988.7.camel@mhcln03>
Message-ID: <Pine.LNX.4.44.0609021908320.28542-100000@sleekfreak.ath.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Sep 2006, Matthias Hentges wrote:

> Am Samstag, den 02.09.2006, 15:41 -0400 schrieb shogunx:
> > On Sat, 2 Sep 2006, Matthias Hentges wrote:
> >
> > > Am Freitag, den 01.09.2006, 22:41 -0400 schrieb shogunx:
> > > > > >
> > > > > > Has this not been fixed in the 2.6.18 git?
> > > > >
> > > > > Good question. I'll try 2.6.18-rc4-mm3 and report back.
> > > >
> > > > I am having no problems with 2.6.18-rc5, which I just built and tested.
> > >
> > > The NIC is up and running for about 9hrs now w/ -rc4-mm3, thanks for the
> > > heads up!
> >
> > Hey, no worries.  I have a friend who has has that problem for some time,
> > and I just got one of those cards myself, albeint in an ExpressCard
> > format.
> >
> > Glad its working.
>
> Well, it just crapped out on me again :(
>
> Sep  2 23:36:13 localhost kernel: NETDEV WATCHDOG: eth2: transmit timed
> out
> Sep  2 23:36:13 localhost kernel: sky2 hardware hung? flushing
>
> Only a rmmod / modprobe cycle helps at this point.

Really?  What is the error condition causing it?  On my friends lap, which
has an integrated sky2, his drops out with a full sustained TX...
uploading to another box for example, at about 4-8MB of transfer.  The
fix in his case is ifdown eth0 && ifup eth0.  I have
yet to see the error occur at all on my ExpressCard device, either with
2.6.18-rc5 or 2.6.17.5.  I built the rc5 as a preemptive measure, but I
cannot get it to fail under any conditions.


> --
> Matthias 'CoreDump' Hentges
>
> Webmaster of hentges.net and OpenZaurus developer.
> You can reach me in #openzaurus on Freenode.
>
> My OS: Debian SID. Geek by Nature, Linux by Choice
>

sleekfreak pirate broadcast
http://sleekfreak.ath.cx:81/


-- 
VGER BF report: U 0.5
