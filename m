Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbUKWGga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbUKWGga (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 01:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbUKWGga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 01:36:30 -0500
Received: from fmr13.intel.com ([192.55.52.67]:6355 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S261460AbUKWGeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 01:34:14 -0500
Subject: [BKPATCH] ACPI for 2.4
From: Len Brown <len.brown@intel.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@stimpy.netroedge.com>
Content-Type: text/plain
Organization: 
Message-Id: <1101191641.20006.454.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 23 Nov 2004 01:34:02 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, please do a 

	bk pull bk://linux-acpi.bkbits.net/24-latest-release

	This should address the "Linux 2.4.28 breaks lm_sensors"
	issue.  It is an exact bkimport from 2.6.

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/24-latest-release/acpi-20040326-24-latest-release.diff.gz

This will update the following files:

 drivers/acpi/motherboard.c |   20 ++++++++++++++++----
 1 files changed, 16 insertions(+), 4 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (04/11/22 1.1458.1.8)
   [ACPI] BIOS workaround allowing devices to use reserved IO ports
   Author: David Shaohua Li
   http://bugzilla.kernel.org/show_bug.cgi?id=3049




