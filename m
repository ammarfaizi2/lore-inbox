Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbTKGWVz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbTKGWVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:21:30 -0500
Received: from modemcable137.219-201-24.mc.videotron.ca ([24.201.219.137]:41091
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S264480AbTKGQwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 11:52:22 -0500
Date: Fri, 7 Nov 2003 11:51:33 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [PATCH][2.6] Don't disable IOAPIC with nosmp
In-Reply-To: <Pine.LNX.4.32.0311071237410.5945-100000@jurand.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.53.0311071151030.27287@montezuma.fsmlabs.com>
References: <Pine.LNX.4.32.0311071237410.5945-100000@jurand.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Nov 2003, Maciej W. Rozycki wrote:

> On Wed, 5 Nov 2003, Zwane Mwaikambo wrote:
> 
> > This patch addresses bugzilla bug#1487
> > http://bugme.osdl.org/show_bug.cgi?id=1487
> >
> > We're disabling the IOAPIC when someone boots with the nosmp kernel
> > parameter, this happens to break interrupt routing for some folks.
> 
>  I object -- that's a feature.  Use "maxcpus=1" instead of "nosmp" or
> "maxcpus=0" (which is an equivalent) to keep APICs enabled with a single
> CPU running.

Nick does maxcpus=1 work for you?
