Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbWFNWWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbWFNWWw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 18:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbWFNWWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 18:22:50 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:3163 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932415AbWFNWWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 18:22:43 -0400
Message-ID: <44909A61.4080104@oracle.com>
Date: Wed, 14 Jun 2006 16:23:13 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       len.brown@intel.com
Subject: [Ubuntu -mm PATCH] acpi/sony: Add FN hotkey support
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Garrett <mjg59@srcf.ucam.org>

in -mm only

[UBUNTU:acpi/sony] Add FN hotkey support
Source URL of Patch:
http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=7a9b49cba4919e8506604629db03add8e0b85767

Signed-off-by: Ben Collins <bcollins@ubuntu.com>
---

--- a/drivers/acpi/sony_acpi.c
+++ b/drivers/acpi/sony_acpi.c
@@ -87,6 +87,11 @@ static struct sony_acpi_value {
 		.max		= 8,
 		.debug		= 0,
 	},
+        {
+		.name           = "fnkey",
+		.acpiget        = "GHKE",
+		.debug          = 0,
+	}, 
 	{
 		.name		= "cdpower",
 		.acpiget	= "GCDP",

