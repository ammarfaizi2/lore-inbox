Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751431AbWDOUVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbWDOUVS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 16:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWDOUVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 16:21:18 -0400
Received: from xenotime.net ([66.160.160.81]:59297 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751268AbWDOUVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 16:21:17 -0400
Date: Sat, 15 Apr 2006 13:23:43 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, sam@ravnborg.org,
       rmk+serial@arm.linux.org.uk
Subject: modpost: serial/8250_pci warnings
Message-Id: <20060415132343.544357a2.rdunlap@xenotime.net>
In-Reply-To: <20060415111712.311372aa.rdunlap@xenotime.net>
References: <20060415111712.311372aa.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


drivers/serial/8250_pci.o has 23 section mismatch warnings.
They are all related to (come from) this struct:

static struct pci_serial_quirk pci_serial_quirks[] = {

so maybe either "quirk" can go into the whitelist, or
Russell can tell us if these are false positives or need to be
fixed.

---
~Randy
