Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268379AbUJJRfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268379AbUJJRfi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 13:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268382AbUJJRfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 13:35:38 -0400
Received: from fmr06.intel.com ([134.134.136.7]:56993 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S268379AbUJJRfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 13:35:36 -0400
Subject: [BKPATCH] LAPIC fix for 2.6
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Content-Type: text/plain
Organization: 
Message-Id: <1097429707.30734.21.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 10 Oct 2004 13:35:07 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please do a 

	bk pull bk://linux-acpi.bkbits.net/26-latest-release

	I recommend that we include this patch in 2.6.9.

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/26-latest-release/acpi-20040816-26-latest-release.diff.gz

This will update the following files:

 arch/i386/kernel/apic.c |    6 ++++++
 1 files changed, 6 insertions(+)

through these ChangeSets:

<len.brown@intel.com> (04/10/10 1.2158)
   [ACPI] If BIOS disabled the LAPIC, believe it by default.
   "lapic" is available to force enabling the LAPIC
   in the event you know more than your BIOS vendor.
   http://bugzilla.kernel.org/show_bug.cgi?id=3238




