Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268174AbTB1WTD>; Fri, 28 Feb 2003 17:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268209AbTB1WTD>; Fri, 28 Feb 2003 17:19:03 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:43781 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S268174AbTB1WTC>; Fri, 28 Feb 2003 17:19:02 -0500
Date: Fri, 28 Feb 2003 23:29:11 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Sam Ravnborg <sam@ravnborg.org>
cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 423] New: make -j X bzImage gives a warning
In-Reply-To: <20030228212504.GA21843@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0302282326020.32518-100000@serv>
References: <347860000.1046465385@flay> <20030228212504.GA21843@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 28 Feb 2003, Sam Ravnborg wrote:

> >            Summary: make -j X bzImage gives a warning
> >     Kernel Version: 2.5.63
> >             Status: NEW
> >           Severity: low	
> >              Owner: zippel@linux-m68k.org
> 
> Feel free to bug me with kbuild related issues.

A 'kernel build' component wouldn't be a bad idea. :)

> > Can we get rid of this one way or the other?
> 
> I have tried before - no luck.
> This one happens due to a $(Q)$(MAKE) used as part of a $(if
> construct in the top-level Makefile.

If I add a '+' in front of the $(Q), the warning goes away?

bye, Roman

