Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264268AbUD0SG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264268AbUD0SG1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 14:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264251AbUD0SET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 14:04:19 -0400
Received: from fmr02.intel.com ([192.55.52.25]:49537 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S264258AbUD0SCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 14:02:55 -0400
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
	for idle=C1halt, 2.6.5
From: Len Brown <len.brown@intel.com>
To: a.verweij@student.tudelft.nl
Cc: Ross Dickson <ross@datscreative.com.au>,
       Jesse Allen <the3dfxdude@hotmail.com>,
       "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       Craig Bradney <cbradney@zip.com.au>, christian.kroener@tu-harburg.de,
       linux-kernel@vger.kernel.org, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>, Daniel Drake <dan@reactivated.net>,
       Ian Kumlien <pomac@vapor.com>, Allen Martin <AMartin@nvidia.com>
In-Reply-To: <Pine.GHP.4.44.0404271807470.6154-100000@elektron.its.tudelft.nl>
References: <Pine.GHP.4.44.0404271807470.6154-100000@elektron.its.tudelft.nl>
Content-Type: text/plain
Organization: 
Message-Id: <1083088854.2322.38.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 27 Apr 2004 14:00:54 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-27 at 13:02, Arjen Verweij wrote:

> After having his box run with cat /dev/hda > /dev/null for a night
> straight no lockup has occured. The brand of his motherboard is Shuttle.

My shuttle is a FN41 board in a SN41G2 system.

I found "rev 1.0" BIOS (FN41S00X of 12/18/2002) on Shuttle's ftp site
and downgraded to that, but still no hang.

It may be this board never hangs no matter what,
or perhaps C1 disconnect was simply disabled in that BIOS
b/c there was no option for it in Advanced Chipset Features
like there is for the most recent BIOS.

Other things about my board.
I run "optimized defaults", I don't overclock anything.
Processor is an AMD XP 2200+
Does anybody else see the hang with this processor model?
I wonder if the hang is processor model or speed dependent?

> Does anyone have some input on how to tackle this problem?

Unfortunately I don't have tools for debugging nvidia + amd hardware.
I would expect that those companies do, however.  So encouraging them
to reproduce the hang internally may be the best way to go.

> buy Len the cheapest broken nforce2 board I can find at pricewatch.com and
> have it shipped to his house :)

I got tangled in this b/c this board (actually, the reference BIOS for
this chipset) had some unusual ACPI related failures.  If the failures
turn out to be related to ACPI, I'll do what I can to help.  But I
expect that hardware debugging tools may be necessary before the
hang issue is completely explained and solved.

-Len


