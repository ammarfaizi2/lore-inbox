Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265340AbUAPKoh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 05:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265362AbUAPKoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 05:44:37 -0500
Received: from intra.cyclades.com ([64.186.161.6]:36836 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265340AbUAPKof
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 05:44:35 -0500
Date: Fri, 16 Jan 2004 08:30:13 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Andrew Walrond <andrew@walrond.org>
Cc: "Yu, Luming" <luming.yu@intel.com>,
       Stephan von Krawczynski <skraw@ithnet.com>, andreas@xss.co.at,
       linux-kernel@vger.kernel.org
Subject: Re: ACPI: problem on ASUS PR-DLS533
In-Reply-To: <200401151814.35064.andrew@walrond.org>
Message-ID: <Pine.LNX.4.58L.0401160826090.28357@logos.cnet>
References: <3ACA40606221794F80A5670F0AF15F8401720CA8@PDSMSX403.ccr.corp.intel.com>
 <200401151814.35064.andrew@walrond.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 15 Jan 2004, Andrew Walrond wrote:

> On Monday 12 Jan 2004 5:14 am, Yu, Luming wrote:
> > >> >I have some TRL-DLS here (P-III). They have dual AIC onboard which
> >
> > are
> >
> > >> not
> > >>
> > >> >recognised under 2.4.24 but work flawlessly with ACPI in 2.4.23.
> > >>
> > >> Are you sure?  You seems to want to say this is a regression.
> > >
> > >Yes. That is exactly what happened.
> > >
> > >2.4.23 works flawlessly
> > >2.4.24 does not recognise both onboard aic
> >
> > Since you are so sure, could you file a tracker on bugzilla, and post
> > info
> > to demonstrate that fact. It's really interesting.
> > -
>
> I don't know if Stephan filed the report as you requested, but I have tried to
> independantly confirm this regression on a TR-DLSR server I have here, but
> unfortunately neither 2.4.23 or 2.4.24 will boot from the Mylex 170 Raid card
> (DAC960) with ACPI enabled, so I never get to lspci :(
>
> I could perhaps capture the boot messages over serial port, if that would be
> helpful?

Yes, please, with and without ACPI. (I suppose disabling ACPI fixes the
problem?)

Stephan: There is nothing from 2.4.23 to .24 which could cause such
breakage. It probably didnt work with 2.4.23 also?
