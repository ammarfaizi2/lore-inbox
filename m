Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262821AbSKYKJ4>; Mon, 25 Nov 2002 05:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262824AbSKYKJ4>; Mon, 25 Nov 2002 05:09:56 -0500
Received: from [81.2.122.30] ([81.2.122.30]:48388 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S262821AbSKYKJr>;
	Mon, 25 Nov 2002 05:09:47 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200211251027.gAPARdGD000360@darkstar.example.net>
Subject: Re: 2.4.20-rc3 keyboard & mouse lost in X
To: murrayr@brain.org (Murray J. Root)
Date: Mon, 25 Nov 2002 10:27:39 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021124233045.GA1747@Master.Wizards> from "Murray J. Root" at Nov 24, 2002 06:30:45 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > > I've mentioned it before many times, (since 2.4.20-pre8) so I'll just
> > > > > mention - it still happens.

You didn't CC me in on this reply - although I am subscribed to LKML,
like most subscribers, I don't read every single message on the list,
and could easily have missed your reply - please CC relevant people,
unless they ask you not to.  This may be why you didn't get replies
before :-).

> > > > > Going to X mouse and keyboard stop responding.
> > > > > 
> > > > > Not a good thing, since most users like using X.
> > > > 
> > > > Are you sure it isn't an XF86Config problem?  Does 2.4.19 work?
> > > 
> > > 2.4.19 works - every 2.4.x works up to 2.4.20pre8. pre8 with ac3
> > > works (what I'm using now). If you look back you'll see I've reported
> > > this for many versions (most of 2.5.4x has the same problem).
> > 
> > Try disabling the local APIC, if it is enabled.
> 
> This caused the keyboard to work in X.

Good.

> Mouse still not responsive.
> I do get an error message in syslog after starting X now:
> 
> Nov 24 17:59:12 Master kernel: keyboard: Timeout - AT keyboard not
> present?(00)
> 
> but the keyboard works.

The people I suggest you contact are:

Alan Cox - he will know why disabling the APIC fixed the keyboard
Vojtech Pavlik - he knows all about the input layer code

John.
