Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbWIBX6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbWIBX6J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 19:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbWIBX6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 19:58:09 -0400
Received: from rrcs-24-227-114-150.se.biz.rr.com ([24.227.114.150]:22413 "EHLO
	sleekfreak.ath.cx") by vger.kernel.org with ESMTP id S1751439AbWIBX6G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 19:58:06 -0400
Date: Sat, 2 Sep 2006 19:55:58 -0400 (EDT)
From: shogunx <shogunx@sleekfreak.ath.cx>
To: Matthias Hentges <oe@hentges.net>
cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       Stephen Hemminger <shemminger@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: sky2 hangs on me again: This time 200 kb/s IPv4 traffic, not
 easily reproducable
In-Reply-To: <Pine.LNX.4.44.0609021939100.28542-100000@sleekfreak.ath.cx>
Message-ID: <Pine.LNX.4.44.0609021955380.29305-100000@sleekfreak.ath.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Sep 2006, shogunx wrote:

> On Sun, 3 Sep 2006, Matthias Hentges wrote:
>
> > Am Samstag, den 02.09.2006, 19:11 -0400 schrieb shogunx:
> > > On Sat, 2 Sep 2006, Matthias Hentges wrote:
> >
> > > > Well, it just crapped out on me again :(
> > > >
> > > > Sep  2 23:36:13 localhost kernel: NETDEV WATCHDOG: eth2: transmit timed
> > > > out
> > > > Sep  2 23:36:13 localhost kernel: sky2 hardware hung? flushing
> > > >
> > > > Only a rmmod / modprobe cycle helps at this point.
> > >
> > > Really?  What is the error condition causing it?  On my friends lap, which
> > > has an integrated sky2, his drops out with a full sustained TX...
> > > uploading to another box for example, at about 4-8MB of transfer.  The
> > > fix in his case is ifdown eth0 && ifup eth0.  I have
> > > yet to see the error occur at all on my ExpressCard device, either with
> > > 2.6.18-rc5 or 2.6.17.5.  I built the rc5 as a preemptive measure, but I
> > > cannot get it to fail under any conditions.
> > >
> >
> > I have yet to find a reproduceable way to trigger the bug but I'll try a
> > few things tomorrow.
> > Currently it appears to be completely ranom. I've loaded the driver w/
> > debug=10, maybe it'll give some clues.
>
> Ack.  Awaiting more info.  I pushed it pretty hard last night with both
> kernel revisions, scp'ing cd iso images and kernel tarballs back and forth
> across the interface, and could not get it to lock.  I am using a 88E8053
> chipset.  I'll ask my friend what chipset his is.

He is using a 88E8036, JFYI.


Perhaps its a
> different bug that is hitting you now...
>
> > --
> > Matthias 'CoreDump' Hentges
> >
> > Webmaster of hentges.net and OpenZaurus developer.
> > You can reach me in #openzaurus on Freenode.
> >
> > My OS: Debian SID. Geek by Nature, Linux by Choice
> >
>
> sleekfreak pirate broadcast
> http://sleekfreak.ath.cx:81/
>
>
> --
> VGER BF report: U 0.5
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

sleekfreak pirate broadcast
http://sleekfreak.ath.cx:81/


-- 
VGER BF report: U 0.500006
