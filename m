Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267489AbTBFSFW>; Thu, 6 Feb 2003 13:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267488AbTBFSFW>; Thu, 6 Feb 2003 13:05:22 -0500
Received: from node181b.a2000.nl ([62.108.24.27]:18311 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id <S267476AbTBFSFT>;
	Thu, 6 Feb 2003 13:05:19 -0500
Date: Thu, 6 Feb 2003 19:15:11 +0100 (CET)
From: Stephan van Hienen <raid@a2000.nu>
To: "Peter L. Ashford" <ashford@sdsc.edu>
cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Promise FastTrak TX4 losing interrupts (with apic mode)
In-Reply-To: <Pine.GSO.4.30.0302060728320.15885-100000@multivac.sdsc.edu>
Message-ID: <Pine.LNX.4.53.0302061913210.17629@ddx.a2000.nu>
References: <Pine.GSO.4.30.0302060728320.15885-100000@multivac.sdsc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Feb 2003, Peter L. Ashford wrote:

> I just saw, and fixed, a very similar problem last night (lost interrupts,
> but partition table was eventually read).  The system was a dual Xeon on a
> P4DP6.  The Promise card was an Ultra100TX2.  The OS was RedHat 7.3.
>
> The fix was to increase the bus master time for the PCI slot in the BIOS.
> This was also tried under SuSE 8.1, where it did NOT work.

ultra100tx2 / ultra66 cards work ok in the machines i tested it in (and
also the onboard fasttrak100 on the xeon server (intel mainbord))

