Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUCHWLM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 17:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbUCHWK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 17:10:56 -0500
Received: from palrel11.hp.com ([156.153.255.246]:15034 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S261375AbUCHWKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 17:10:35 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16460.61267.364413.100233@napali.hpl.hp.com>
Date: Mon, 8 Mar 2004 14:10:27 -0800
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, davidm@hpl.hp.com,
       Takayoshi Kochi <t-kochi@bq.jp.nec.com>, benjamin.liu@intel.com,
       iod00d@hp.com, kaneshige.kenji@jp.fujitsu.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix PCI interrupt setting for ia64
In-Reply-To: <200403081505.21644.bjorn.helgaas@hp.com>
References: <3ACA40606221794F80A5670F0AF15F8401B1A017@PDSMSX403.ccr.corp.intel.com>
	<16460.59685.452893.22564@napali.hpl.hp.com>
	<20040308215448.I21938@flint.arm.linux.org.uk>
	<200403081505.21644.bjorn.helgaas@hp.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 8 Mar 2004 15:05:21 -0700, Bjorn Helgaas <bjorn.helgaas@hp.com> said:

  Bjorn> My inclination is that it's better to help find ACPI bugs,
  Bjorn> and if broken tables turn out to be a problem, we can add
  Bjorn> some kind of command-line switch or blacklist to deal with
  Bjorn> it.  But I guess we should really get David's opinion, since
  Bjorn> this is a potential issue for 2.6 distributions.

I agree with Bjorn's reasoning, but think that the patch should be
tested first on a Big Sur machine (with the latest official firmware).
If something breaks with old firmware, we can then at least ask the
affected people to upgrade their firmware (or come up with a kernel
workaround).

	--david
