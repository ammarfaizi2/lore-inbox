Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266169AbUAGJdz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 04:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266170AbUAGJdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 04:33:54 -0500
Received: from fmr06.intel.com ([134.134.136.7]:38850 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S266169AbUAGJdx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 04:33:53 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [ACPI] ACPI battery issue - Dell Inspiron 4150 - 2.6.1-rc1-mm2 
Date: Wed, 7 Jan 2004 17:33:29 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8401720C86@PDSMSX403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] ACPI battery issue - Dell Inspiron 4150 - 2.6.1-rc1-mm2 
Thread-Index: AcPUApsJar0H0sGVTNiJTNibAEnSWAA/hFwg
From: "Yu, Luming" <luming.yu@intel.com>
To: <Valdis.Kletnieks@vt.edu>, "Dax Kelson" <dax@gurulabs.com>
Cc: <linux-kernel@vger.kernel.org>, <acpi-devel@lists.sourceforge.net>,
       "Brown, Len" <len.brown@intel.com>
X-OriginalArrivalTime: 07 Jan 2004 09:33:48.0966 (UTC) FILETIME=[5AAFCC60:01C3D501]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> charging state:          unknown
>> present rate:            unknown
>
>I can't say for certain, but I think it's a tad confused - it can
report 
>'charging', and 'discharging', but doesn't know what to say if the
battery
>is at 100% and you're running off AC....It's been that way on mine at
>least since 2.5.7mumble or maybe 2.4.18, so it's NOT a regression from
the
>recent ACPI patch.

Let me see DSDT (/proc/acpi/dsdt) , and check whether it is a real bug
or
 just short of words.
