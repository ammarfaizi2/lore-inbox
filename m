Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267244AbTALQ6X>; Sun, 12 Jan 2003 11:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267254AbTALQ6W>; Sun, 12 Jan 2003 11:58:22 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:18838
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267244AbTALQ6V>; Sun, 12 Jan 2003 11:58:21 -0500
Subject: Re: Intel And Kenrel Programming (was: Nvidia is a great company)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: robw@optonline.net
Cc: Chuck Wolber <chuckw@quantumlinux.com>, Valdis.Kletnieks@vt.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1042390735.1208.5.camel@RobsPC.RobertWilkens.com>
References: <Pine.LNX.4.44.0301112346450.2270-100000@bailey.scraps.org>
	 <1042382565.848.11.camel@RobsPC.RobertWilkens.com>
	 <1042389923.15051.1.camel@irongate.swansea.linux.org.uk>
	 <1042390735.1208.5.camel@RobsPC.RobertWilkens.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042394046.15051.21.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 12 Jan 2003 17:54:07 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-12 at 16:58, Rob Wilkens wrote:
> The hardware engineers, in my experience, will not refer to those issues
> as bugs, but rather as misdocumented features... No?  I mean if an
> errata is enough to work around the problem, then the documentation was
> clearly the problem, and not the hardware implementation.

Intel seperate out things that are docmentation errors, clarifications
and actual bugs. They publish regular errata documents listing these,
and when they do decide to turn a flaw into a specification update they
document that too. AMD likewise.

Some vendors may not do this, but the x86 CPU vendors seem to do a good
job.

> As per the microcode updates, I noticed RedHat 8 was autoupdating
> microcode on each boot IIRC. I've since switched to Debian and don't
> know that it does this.  Should I be concerned?

It depends on your chip revisions. For example the O(1) scheduler will trigger 
very occasional random crashes or reboots with early PII Xeon microcode sets.
I'm sure Debian has a package for this somewhere.

Alan

