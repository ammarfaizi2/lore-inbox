Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312619AbSGASjh>; Mon, 1 Jul 2002 14:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313687AbSGASjg>; Mon, 1 Jul 2002 14:39:36 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:58127 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S312619AbSGASjf>; Mon, 1 Jul 2002 14:39:35 -0400
Date: Mon, 1 Jul 2002 14:36:42 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
cc: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: lilo/raid?
In-Reply-To: <200207011802.28264.roy@karlsbakk.net>
Message-ID: <Pine.LNX.3.96.1020701143402.24024A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jul 2002, Roy Sigurd Karlsbakk wrote:

> On Monday 01 July 2002 17:52, Bill Davidsen wrote:
> > On Mon, 1 Jul 2002, Roy Sigurd Karlsbakk wrote:
> > > still - sorry if this is OT - I'm just too close to tear my hair or head
> > > off or something
> > >
> > > The documentation everywhere, including the lilo 22.3.1 sample conf ffile
> > > tells me "use boot = /dev/md0", but lilo, when run, just tells me
> > >
> > > Fatal: Filesystem would be destroyed by LILO boot sector: /dev/md0
> >
> > I saw something like that when someone had made a raid device by hand and
> > used hda and hdb instead of hda1 and hdb1.
> 
> problem is: lilo does not seem to install at all with hd[ab]1 given. only 
> hdm(!!!), and then it just goes LI
> 
> See dmesg log at http://karlsbakk.net/bugs/ for more info

No, what I had in mind was that in the raid definition, instead of a
partition such as /dev/hda1, the physical driver was given, like /dev/hda.
That gave the message you mention. In any case you seem to have identified
the problem, so this is probably not relevant.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

