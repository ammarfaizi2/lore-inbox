Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265201AbUAOSOk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 13:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265177AbUAOSOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 13:14:39 -0500
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:24202 "HELO
	cenedra.office") by vger.kernel.org with SMTP id S265173AbUAOSOi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 13:14:38 -0500
From: Andrew Walrond <andrew@walrond.org>
To: "Yu, Luming" <luming.yu@intel.com>,
       "Stephan von Krawczynski" <skraw@ithnet.com>
Subject: Re: ACPI: problem on ASUS PR-DLS533
Date: Thu, 15 Jan 2004 18:14:35 +0000
User-Agent: KMail/1.5.4
Cc: <andreas@xss.co.at>, <linux-kernel@vger.kernel.org>
References: <3ACA40606221794F80A5670F0AF15F8401720CA8@PDSMSX403.ccr.corp.intel.com>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720CA8@PDSMSX403.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401151814.35064.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 Jan 2004 5:14 am, Yu, Luming wrote:
> >> >I have some TRL-DLS here (P-III). They have dual AIC onboard which
>
> are
>
> >> not
> >>
> >> >recognised under 2.4.24 but work flawlessly with ACPI in 2.4.23.
> >>
> >> Are you sure?  You seems to want to say this is a regression.
> >
> >Yes. That is exactly what happened.
> >
> >2.4.23 works flawlessly
> >2.4.24 does not recognise both onboard aic
>
> Since you are so sure, could you file a tracker on bugzilla, and post
> info
> to demonstrate that fact. It's really interesting.
> -

I don't know if Stephan filed the report as you requested, but I have tried to 
independantly confirm this regression on a TR-DLSR server I have here, but 
unfortunately neither 2.4.23 or 2.4.24 will boot from the Mylex 170 Raid card 
(DAC960) with ACPI enabled, so I never get to lspci :(

I could perhaps capture the boot messages over serial port, if that would be 
helpful?

Andrew Walrond

