Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751769AbWBWTvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbWBWTvF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 14:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbWBWTvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 14:51:04 -0500
Received: from fmr19.intel.com ([134.134.136.18]:11229 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751769AbWBWTvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 14:51:03 -0500
Subject: [patch 0/3] New dock patches (v2)
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net
Cc: greg@kroah.com, len.brown@intel.com, muneda.takahiro@jp.fujitsu.com,
       pavel@ucw.cz
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 23 Feb 2006 11:56:11 -0800
Message-Id: <1140724571.11750.15.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 23 Feb 2006 19:50:52.0387 (UTC) FILETIME=[73BF0330:01C638B2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Revised with yesterday's feedback.  Fixed bug in the dock patch which
incorrectly used list_for_each_entry to free memory, updated text in
Kconfig for the removal of docking support from ibm_acpi, and exported
the acpi_bus_trim symbol GPL.

Thanks for reviewing,
Kristen
