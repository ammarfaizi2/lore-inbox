Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751627AbWEEQ1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbWEEQ1M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 12:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751636AbWEEQ1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 12:27:11 -0400
Received: from xenotime.net ([66.160.160.81]:8337 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751624AbWEEQ1K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 12:27:10 -0400
Date: Fri, 5 May 2006 09:27:06 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Jes Sorensen <jes@sgi.com>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Brent Casavant <bcasavan@sgi.com>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, akpm@osdl.org,
       jeremy@sgi.com
Subject: Re: [PATCH] Move various PCI IDs to header file
In-Reply-To: <445AE690.5030700@sgi.com>
Message-ID: <Pine.LNX.4.58.0605050926250.3161@shark.he.net>
References: <20060504180614.X88573@chenjesu.americas.sgi.com>
 <20060504173722.028c2b24.rdunlap@xenotime.net> <445AE690.5030700@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 May 2006, Jes Sorensen wrote:

> Randy.Dunlap wrote:
> > On Thu, 4 May 2006 18:09:45 -0500 (CDT) Brent Casavant wrote:
> >
> >> Move various QLogic, Vitesse, and Intel storage
> >> controller PCI IDs to the main header file.
> >>
> >> Signed-off-by: Brent Casavant <bcasavan@sgi.com>
> >>
> >> ---
> >>
> >> As suggested by Andrew Morton and Jes Sorenson.
> >
> > as compared to:
> > http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=9b860b8c4bde5949b272968597d1426d53080532
>
> I guess Andrew and I should be blamed for that. I Andrew suggested
> putting the IDs in the 'right place' and I took the right place as being
> the pci_ids.h file.
>
> Can't say I agree with the recommendation, having them in pci_ids.h is
> nice and clean and it allows one to go look through the list, instead
> they now really become random hex values :( Brent's patch is a perfect
> example of IDs being used in multiple places, ie. the qla1280 driver
> and in the IOC4 driver, so the claim in that Documentation/ file doesn't
> hold water.
>
> Anyway, if this is the new rule, then I guess it's back to using the
> ugly patch :(

FWIW, I'm not saying that I agree with the new rule, just that
it's there/merged.

-- 
~Randy
