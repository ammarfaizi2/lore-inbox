Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbTJ2H73 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 02:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbTJ2H73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 02:59:29 -0500
Received: from fmr04.intel.com ([143.183.121.6]:29623 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S261889AbTJ2H72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 02:59:28 -0500
Subject: [BK PATCH] ACPI 2.6
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Content-Type: text/plain
Organization: 
Message-Id: <1067414344.15257.5.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 29 Oct 2003 02:59:05 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please do a 

	bk pull http://linux-acpi.bkbits.net/linux-acpi-release-2.6.0

	These two csets undo recent changes that caused crashes.

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.0-test9/acpi-20031002-2.6.0-test9.diff.gz

This will update the following files:

 drivers/acpi/dispatcher/dsopcode.c |    8 +++-----
 drivers/acpi/ec.c                  |   16 ++--------------
 2 files changed, 5 insertions(+), 19 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (03/10/28 1.1373)
   [ACPI] REVERT ACPICA-20030918 CONFIG_ACPI_DEBUG printk that caused
crash
   http://bugzilla.kernel.org/show_bug.cgi?id=1341

<len.brown@intel.com> (03/10/28 1.1372)
   [ACPI] REVERT acpi_ec_gpe_query(ec) fix that crashed non-T40 boxes
   http://bugme.osdl.org/show_bug.cgi?id=1171




