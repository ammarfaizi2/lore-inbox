Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265245AbTLFU47 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 15:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265246AbTLFU47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 15:56:59 -0500
Received: from burp.tkv.asdf.org ([212.16.99.49]:42122 "EHLO burp.tkv.asdf.org")
	by vger.kernel.org with ESMTP id S265245AbTLFU45 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 15:56:57 -0500
Date: Sat, 6 Dec 2003 22:56:43 +0200
Message-Id: <200312062056.hB6Kuh0D001004@burp.tkv.asdf.org>
From: Markku Savela <msa@burp.tkv.asdf.org>
To: zwane@arm.linux.org.uk
CC: linux-kernel@vger.kernel.org
In-reply-to: <Pine.LNX.4.58.0312061253010.10548@montezuma.fsmlabs.com>
	(message from Zwane Mwaikambo on Sat, 6 Dec 2003 12:53:16 -0500 (EST))
Subject: Re: 2.6.0-test11, TSC cannot be used as a timesource.
References: <200312061603.hB6G3CrG012634@burp.tkv.asdf.org> <Pine.LNX.4.58.0312061253010.10548@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
> On Sat, 6 Dec 2003, Markku Savela wrote:
> 
> > I've seen some references to above problem, but no clear answer. The
> > 'ntpd' is complaining a lot...
> >
> > I have ASUS P4S800. Here is some extracts from dmesg (I can provide
> > more complete dump, if anyone wants something specific.)
> 
> Does this only happen when running X11?

Hmm.. possibly. When I boot single user, it does not appear to happen.

After "init 2" and X and everything running, the notice appears in
about 5-10 minutes. All I have in X is couple of XTerms and doing
occasional "dmesg". I have Gnome2 with Sawfish, and GKrellM running.

Yes, my X is for older kernel

  XFree86 Version 4.3.0
  Release Date: 27 February 2003
  X Protocol Version 11, Revision 0, Release 6.6
  Build Operating System: Linux 2.4.18-24.8.0smp i686 [ELF]

and I had to disable "dri" loading totally. If I enable "dri", and
start X that uses it, the machines crashes totally, no X logs, no
syslog or anything comes out. Total death (I just assumes that
expecting DRI to work was just too much). Maybe I should disable all
acceleration...

