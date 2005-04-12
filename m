Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262460AbVDLNOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262460AbVDLNOx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 09:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbVDLNMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 09:12:25 -0400
Received: from mailfe09.tele2.se ([212.247.155.1]:30413 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262455AbVDLNJE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 09:09:04 -0400
X-T2-Posting-ID: dB8bZLHXm6KAmbp1mi7F+A==
Subject: Re: 2.6.12-rc2-mm3: 10 seconds of nothingness
From: Alexander Nyberg <alexn@dsv.su.se>
To: Mark Rosenstand <mark@bootless.dk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050412111351.1AE61BDEB@valhalla.bootless.dk>
References: <20050412111351.1AE61BDEB@valhalla.bootless.dk>
Content-Type: text/plain
Date: Tue, 12 Apr 2005 15:08:53 +0200
Message-Id: <1113311333.901.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [   19.617890] Testing NMI watchdog ... <6>ACPI: No ACPI bus support
> for 2-2 [   19.705673] ACPI: No ACPI bus support for 2-2:1.0
> [   20.002417] usb 3-2: new full speed USB device using uhci_hcd and
> address 2 [   20.121763] ACPI: No ACPI bus support for 3-2
> [   20.156293] ACPI: No ACPI bus support for 3-2:1.0
> [   29.539613] OK.
> 
> I also had this "problem" with mm1. mm2 wouldn't compile, so I didn't
> test that. IIRC it also happened with the rc1-mm's. Is this supposed to
> happen?

It's a fairly new thing on x64, should be fixed soon. If it disturbs you
too much back out

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm3/broken-out/rfc-check-nmi-watchdog-is-broken.patch

