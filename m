Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266552AbUBLXfr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 18:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266581AbUBLXfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 18:35:47 -0500
Received: from fed1mtao05.cox.net ([68.6.19.126]:21476 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S266552AbUBLXfp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 18:35:45 -0500
Date: Thu, 12 Feb 2004 16:37:52 -0700
From: Jesse Allen <the3dfxdude@hotmail.com>
To: Craig Bradney <cbradney@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6, 2.4, Nforce2, Experimental idle halt workaround instead of apic ack delay.
Message-ID: <20040212233752.GA1479@tesore.local>
Mail-Followup-To: Jesse Allen <the3dfxdude@hotmail.com>,
	Craig Bradney <cbradney@zip.com.au>, linux-kernel@vger.kernel.org
References: <200402120122.06362.ross@datscreative.com.au> <Pine.LNX.4.58.0402121118490.515@gonopodium.signalmarketing.com> <20040212214407.GA865@tesore.local> <Pine.LNX.4.58.0402121544470.962@gonopodium.signalmarketing.com> <1076623565.16585.11.camel@athlonxp.bradney.info> <20040212230456.GA911@tesore.local> <1076627706.16600.20.camel@athlonxp.bradney.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1076627706.16600.20.camel@athlonxp.bradney.info>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 13, 2004 at 12:15:06AM +0100, Craig Bradney wrote:
> On Fri, 2004-02-13 at 00:04, Jesse Allen wrote:
> > vanilla kernels = 2.6.0-test11 through 2.6.3-rc2 and no patches.  APIC is 
> > on.
> 
> and local APIC and ACPI?

Yes.

> > 12-5-2003 BIOS:
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=107124823504332&w=2
> > 
> > not lock up:
> > I could reproduce the lockup consistantly.  With the 12-5-2003 bios, I 
> > cannot.  Two months have passed since the original report.
> 
> If thats the case you are a lucky person!

I know =)

> > I don't know how to identify a fix from my bioses.  If someone has any 
> > clue, I will help out.
> 
> No idea either.. but the "uber bios"
> (http://homepage.ntlworld.com/michael.mcclay/)
> guy might be able to help some of us out if the changes were found... if
> you trust someone other than your motherboard manufacturer writing
> BIOSes.. but I guess thats the same as any OS project in some ways.
> 

What we need is a kernel patch, because it will be difficult to produce bios 
fixes for each bios iteration.  If he can identify what the changes are in my 
bios and identify a bug, then a sufficiently talented kernel hacker can produce
the work-around for other buggy bioses.


Jesse

