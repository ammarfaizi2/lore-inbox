Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752126AbWCGIwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752126AbWCGIwv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 03:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752124AbWCGIwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 03:52:51 -0500
Received: from fmr20.intel.com ([134.134.136.19]:27790 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1752123AbWCGIwu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 03:52:50 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 2.6.15.3 1/1] ACPI: Atlas ACPI driver
Date: Tue, 7 Mar 2006 16:52:46 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840B22A242@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.15.3 1/1] ACPI: Atlas ACPI driver
thread-index: AcZBic7yCQpvpXbPShqNkM2Bnx6bXgANVMYQ
From: "Yu, Luming" <luming.yu@intel.com>
To: "Jaya Kumar" <jayakumar.acpi@gmail.com>
Cc: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 07 Mar 2006 08:52:47.0812 (UTC) FILETIME=[82100040:01C641C4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I've added it as an attachment here. Please let me know if you get it.
>
I just found this:
            Device (SVG)
                Device (LCD)
It looks too simple to fit video.c.

But it is quite easy to implement in hotkey.c.
Because it has dedicated device with HID and , 
well-known method name.

Ideally, you can enable this jus like this:
http://bugzilla.kernel.org/attachment.cgi?id=6843&action=view

Note, the latest hotkey.c need patch at
http://bugzilla.kernel.org/show_bug.cgi?id=5749


Thanks,
Luming
