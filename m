Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbUJYEr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbUJYEr7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 00:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbUJYEr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 00:47:59 -0400
Received: from HELIOUS.MIT.EDU ([18.238.1.151]:22407 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S261366AbUJYErz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 00:47:55 -0400
Date: Mon, 25 Oct 2004 00:49:12 -0400
From: Adam Belay <ambx1@neo.rr.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, "Brown, Len" <len.brown@intel.com>
Subject: [BK PATCH] PnP Fixes for 2.6.10-rc1
Message-ID: <20041025044912.GC3989@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, "Brown, Len" <len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This changeset contains a few small fixes.

Please Pull from: bk://linux-pnp.bkbits.net/pnp-stable

Thanks,
Adam

*note: this bk address is different from the previous one.

 drivers/pnp/pnpbios/core.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)
-------

<nacc:us.ibm.com>:
  o [PNPBIOS] use msleep_interruptible()

Adam Belay:
  o [PNPBIOS] acpi compile fix
  o [PNPBIOS] disable if ACPI is active
