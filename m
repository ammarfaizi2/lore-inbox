Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751421AbWCMDfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbWCMDfI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 22:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWCMDfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 22:35:08 -0500
Received: from fmr17.intel.com ([134.134.136.16]:9881 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751275AbWCMDfG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 22:35:06 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [2.6 patch] drivers/acpi/video.c: fix a NULL pointer dereference
Date: Sun, 12 Mar 2006 22:33:59 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3006597182@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6 patch] drivers/acpi/video.c: fix a NULL pointer dereference
Thread-Index: AcZFHqkftZ8WA6FUQjW8y8zfZgcwzwBMDu9g
From: "Brown, Len" <len.brown@intel.com>
To: "Adrian Bunk" <bunk@stusta.de>
Cc: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 13 Mar 2006 03:34:01.0988 (UTC) FILETIME=[F8A95C40:01C6464E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

applied,
thanks,
-len


>-	if (!obj && (obj->type != ACPI_TYPE_PACKAGE)) {
>+	if (!obj || (obj->type != ACPI_TYPE_PACKAGE)) {
