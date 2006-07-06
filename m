Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751048AbWGFX3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbWGFX3s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 19:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbWGFX3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 19:29:47 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:29920 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1751043AbWGFX3r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 19:29:47 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: linux-acpi@vger.kernel.org
Subject: [ANNOUNCE] pnputils-0.1
Date: Thu, 6 Jul 2006 17:29:42 -0600
User-Agent: KMail/1.8.3
Cc: David Hinds <dhinds@sonic.net>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607061729.42210.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There used to be an "lspnp" buried in the pcmcia-cs package.  That
package seems to be obsolete, and it's now a strange place for PNP
utilities anyway.

So I pulled out lspnp and setpnp from pcmcia-cs and put them together
in a little "pnputils" package.

I also extended it slightly, so lspnp will work for ISAPNP and
PNPACPI devices in addition to PNPBIOS, and added a few PNP device
IDs.  setpnp still only works for PNPBIOS.

ftp://ftp.kernel.org/pub/linux/kernel/people/helgaas/pnputils-0.1.tar.gz
