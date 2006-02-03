Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWBCM2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWBCM2t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 07:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWBCM2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 07:28:49 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:17793 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750733AbWBCM2s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 07:28:48 -0500
Date: Fri, 3 Feb 2006 13:28:13 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Dave Jones <davej@redhat.com>
cc: Sam Ravnborg <sam@ravnborg.org>, Michael Loftis <mloftis@wgops.com>,
       David Weinehall <tao@acc.umu.se>, Doug McNaught <doug@mcnaught.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Valdis.Kletnieks@vt.edu,
       dtor_core@ameritech.net, James Courtier-Dutton <James@superbug.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
In-Reply-To: <20060202221023.GJ11831@redhat.com>
Message-ID: <Pine.LNX.4.61.0602031323070.9696@scrub.home>
References: <200601201903.k0KJ3qI7006425@turing-police.cc.vt.edu>
 <E27F809F04C1C673D283E84F@d216-220-25-20.dynip.modwest.com>
 <20060120200051.GA12610@flint.arm.linux.org.uk>
 <5793EB6F192350088E0AC4CE@d216-220-25-20.dynip.modwest.com>
 <87slrio9wd.fsf@asmodeus.mcnaught.org> <25D702FB62516982999D7084@d216-220-25-20.dynip.modwest.com>
 <20060202121653.GI20484@vasa.acc.umu.se> <67A0AFFBC77C32B9DEE25EFA@dhcp-2-206.wgops.com>
 <20060202201008.GD11831@redhat.com> <20060202220519.GA8712@mars.ravnborg.org>
 <20060202221023.GJ11831@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2 Feb 2006, Dave Jones wrote:

> -rw-r--r--    1 davej    davej        4613 Dec 15 23:31 linux-2.6-build-nonintconfig.patch
> 
> Adds a 'nonintconfig' target that behaves like oldconfig, but doesn't
> ask any questions (takes the default answer), and prints out a list
> at the end of all the options it didn't know about.
> (Handy when rebasing, as it means I get to add all the new options
>  in one swoop).

You also get the default answers with 'yes "" | make oldconfig', but what 
exactly are you doing with the list of config options?
What are the changes to confdata.c for?

bye, Roman
