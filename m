Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271812AbTHHXRy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 19:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271885AbTHHXRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 19:17:54 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:62887 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S271812AbTHHXRx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 19:17:53 -0400
Date: Sat, 9 Aug 2003 01:17:33 +0200
From: Pavel Machek <pavel@suse.cz>
To: Flameeyes <dgp85@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LIRC list <lirc-list@lists.sourceforge.net>
Subject: Re: [PATCH] lirc for 2.5/2.6 kernels - 20030802
Message-ID: <20030808231733.GF389@elf.ucw.cz>
References: <1059820741.3116.24.camel@laurelin> <20030807214311.GC211@elf.ucw.cz> <1060334463.5037.13.camel@defiant.flameeyes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060334463.5037.13.camel@defiant.flameeyes>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > * This looks like it should be integrated with drivers/input. After
> >   all remote control is just a strange keyboard. What are reasons that
> >   can't be done?
> This is a port of the drivers from lirc project (http://lirc.sf.net/),
> I'm not going to rewrite it, also because the support for lirc in user
> software is present in many programs, like xine, xawdecode, xmms (with
> plugin) and so on.
> The lirc_client library is simple and flexible, and the project is
> consolidated, i don't see the need to change it, also because can be a
> problem for backport in the 2.4 kernels.

I know about lirc project, and I'd like to see it merged, but if lirc
uses wrong interface, it is unsuitable for the kernel.

Motivation for having same code for infrared controls and normal
keyboards: normal keyboards tend to have "play"/"stop"/"vol+"/"vol-"
keys these days; certainly HP omnibook xe3 has them. It would be nice
to handle them in an uniform way.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
