Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbTIQO3t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 10:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbTIQO3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 10:29:49 -0400
Received: from smtp1.att.ne.jp ([165.76.15.137]:5110 "EHLO smtp1.att.ne.jp")
	by vger.kernel.org with ESMTP id S262768AbTIQO3s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 10:29:48 -0400
Message-ID: <0d5201c37d28$02128d80$63ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Russell King" <rmk@arm.linux.org.uk>, "Greg KH" <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>
References: <1b7201c37a73$844b7030$2dee4ca5@DIAMONDLX60> <20030914091702.B20889@flint.arm.linux.org.uk> <20030916164941.GI3593@kroah.com> <20030916182059.D20141@flint.arm.linux.org.uk>
Subject: Re: 2.6.0-test5 vs. Ethernet cards
Date: Wed, 17 Sep 2003 23:27:55 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Russell King" wrote:
> On Tue, Sep 16, 2003 at 09:49:41AM -0700, Greg KH wrote:
> > On Sun, Sep 14, 2003 at 09:17:02AM +0100, Russell King wrote:
> > > On Sun, Sep 14, 2003 at 12:51:29PM +0900, Norman Diamond wrote:
> > > > Shutdown messages appear on the text console as follows:
> > > > [...]
> > > > Shutting down PCMCIA unregister_netdevice: waiting for eth0 to
> > > > become free. Usage count = 1
> > > > unregister_netdevice: waiting for eth0 to become free. Usage count =
> > > > 1
> > > > [...]
> > > > The only way to shut down at this point is to turn off the power.
> > >
> > > IIRC the problem is your hotplug scripts.  Maybe the hotplug folk can
> > > tell you the minimum version for 2.6.
> >
> > The last release version is the best for 2.6, but this doesn't look
> > like a hotplug script issue at all.
>
> Hmm, ok.  However, in the past when people have upgraded their hotplug
> scripts, the problem goes away.

It will be a while before I have time to try it, sorry.  SuSE 8.2 is
partially installed on that machine now and one day next weekend will
probably finish just that.

> Whatever, it's certainly not a PCMCIA issue either, so I'm at a loss what
> to do about these reports.
> I can only think that the right answer is to bat them all at the netdev
> list, since it is a network device issue.

Stephen Hemminger sent private e-mail guessing that IPV6 bugs might be the
cause.  I did select a number of IPV6 options when building
2.6.0-test[1..5].  Sorry I don't remember if my 2.4.19 included any IPV6
support, and I'm not planning to try a regression test to that one.    I'll
try to find time some weekend to experiment with 2.6.0-test5 and
2.4.20-SuSE8.2 with and without IPV6.

I don't have access to IPV6 at present but figure I will someday, and if I
ever have time to experiment with it then the experimentation time will not
be wasted.  Most of the world (except for North America) will not be able to
survive without IPV6.

