Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbUCHWlr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 17:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbUCHWlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 17:41:47 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:59047 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S261378AbUCHWlm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 17:41:42 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: davidm@hpl.hp.com, David Mosberger <davidm@napali.hpl.hp.com>
Subject: Re: [PATCH] fix PCI interrupt setting for ia64
Date: Mon, 8 Mar 2004 15:41:35 -0700
User-Agent: KMail/1.5.4
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, davidm@hpl.hp.com,
       Takayoshi Kochi <t-kochi@bq.jp.nec.com>, benjamin.liu@intel.com,
       iod00d@hp.com, kaneshige.kenji@jp.fujitsu.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <3ACA40606221794F80A5670F0AF15F8401B1A017@PDSMSX403.ccr.corp.intel.com> <200403081505.21644.bjorn.helgaas@hp.com> <16460.61267.364413.100233@napali.hpl.hp.com>
In-Reply-To: <16460.61267.364413.100233@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403081541.35189.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 March 2004 3:10 pm, David Mosberger wrote:
> I agree with Bjorn's reasoning, but think that the patch should be
> tested first on a Big Sur machine (with the latest official firmware).
> If something breaks with old firmware, we can then at least ask the
> affected people to upgrade their firmware (or come up with a kernel
> workaround).

I've tested it on my i2000, and it seems to work fine.  This is with
firmware version

    W460GXBS2.86E.0117C.P09.200108091154

This is the only BIOS version I found mentioned on www.hp.com,
so I assume it's the latest official version.

