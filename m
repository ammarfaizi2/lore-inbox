Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261894AbSKXXXv>; Sun, 24 Nov 2002 18:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261900AbSKXXXv>; Sun, 24 Nov 2002 18:23:51 -0500
Received: from stroke.of.genius.brain.org ([206.80.113.1]:59264 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S261894AbSKXXXv>; Sun, 24 Nov 2002 18:23:51 -0500
Date: Sun, 24 Nov 2002 18:30:45 -0500
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-rc3 keyboard & mouse lost in X
Message-ID: <20021124233045.GA1747@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20021124214007.GB1597@Master.Wizards> <200211242211.gAOMBSUU000706@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211242211.gAOMBSUU000706@darkstar.example.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 24, 2002 at 10:11:28PM +0000, John Bradford wrote:
> > > > I've mentioned it before many times, (since 2.4.20-pre8) so I'll just
> > > > mention - it still happens.
> > > > Going to X mouse and keyboard stop responding.
> > > > 
> > > > Not a good thing, since most users like using X.
> > > 
> > > Are you sure it isn't an XF86Config problem?  Does 2.4.19 work?
> > 
> > 2.4.19 works - every 2.4.x works up to 2.4.20pre8. pre8 with ac3
> > works (what I'm using now). If you look back you'll see I've reported
> > this for many versions (most of 2.5.4x has the same problem).
> 
> Try disabling the local APIC, if it is enabled.

This caused the keyboard to work in X. Mouse still not responsive.
I do get an error message in syslog after starting X now:

Nov 24 17:59:12 Master kernel: keyboard: Timeout - AT keyboard not present?(00)

but the keyboard works.

> 
> > The ONLY difference between working and not working is the kernel
> > version.
> 
> 2.4.x and 2.5.x have very different input layers, so it is suprising
> that the same problem is occuring with both trees.

Very surprising. I can't test 2.5.49, though, as it won't boot from my
reiserfs v3.6 HD.

-- 
Murray J. Root
------------------------------------------------
DISCLAIMER: http://www.goldmark.org/jeff/stupid-disclaimers/
------------------------------------------------
Mandrake on irc.freenode.net:
  #mandrake & #mandrake-linux = help for newbies 
  #mdk-cooker = Mandrake Cooker 

