Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266214AbUGASQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266214AbUGASQG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 14:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266215AbUGASQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 14:16:06 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:27861 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S266214AbUGASQC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 14:16:02 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Tom L Nguyen <tom.l.nguyen@intel.com>
Subject: MSI to memory?
Date: Thu, 1 Jul 2004 12:15:59 -0600
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407011215.59723.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The conventional use of MSI is for a PCI adapter to generate processor
interrupts by writing to a local APIC.  But I've seen some things
that lead me to believe it would also allow an adapter to write to
things other than a local APIC, i.e., to memory.

If so, is that a useful capability that should be exposed through
the Linux MSI interface?
