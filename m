Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbUKSGnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbUKSGnL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 01:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbUKSGnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 01:43:11 -0500
Received: from fmr01.intel.com ([192.55.52.18]:164 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S261272AbUKSGnG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 01:43:06 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [2.6 patch] IA64 irq.c: remove CONFIG_X86 code
Date: Thu, 18 Nov 2004 22:42:01 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F026C5938@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6 patch] IA64 irq.c: remove CONFIG_X86 code
Thread-Index: AcTN17fRYooRuNh5R/KwI/26f6Y1BQAKmFzQ
From: "Luck, Tony" <tony.luck@intel.com>
To: "Adrian Bunk" <bunk@stusta.de>, <davidm@hpl.hp.com>
Cc: <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 Nov 2004 06:42:02.0598 (UTC) FILETIME=[E08F9860:01C4CE02]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I don't see how this code could ever be used.
>
>Am I correct or did I miss something?
>
>
>diffstat output:
> arch/ia64/kernel/irq.c |   33 ---------------------------------
> 1 files changed, 33 deletions(-)

Thanks to a helpful hint from Christoph earlier this week I put
together a patch that throws away over 900 lines from the ia64
irq.c

http://marc.theaimsgroup.com/?l=linux-ia64&m=110072859114157&w=2

It's queued up in an internal tree waiting for 2.6.11 to open.

Some parts of your patch may still be needed.

-Tony
