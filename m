Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265075AbTFMAFg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 20:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265076AbTFMAFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 20:05:35 -0400
Received: from fmr06.intel.com ([134.134.136.7]:65259 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S265075AbTFMAF3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 20:05:29 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: illegal sleeping function call on shutdown (was Re: 2.5.70-mjb2)
Date: Thu, 12 Jun 2003 17:19:13 -0700
Message-ID: <F760B14C9561B941B89469F59BA3A847E96F63@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: illegal sleeping function call on shutdown (was Re: 2.5.70-mjb2)
Thread-Index: AcMxPigLZFsO5zvYQbOTuKOshdvAtAAAvqUA
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "Ed L Cashin" <ecashin@uga.edu>, <linux-kernel@vger.kernel.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, "Andrew Morton" <akpm@digeo.com>
X-OriginalArrivalTime: 13 Jun 2003 00:19:13.0487 (UTC) FILETIME=[6B08A5F0:01C33141]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Ed L Cashin [mailto:ecashin@uga.edu] 
 [<c011e033>] __might_sleep+0x4f/0x53
 [<c01fcecf>] acpi_os_wait_semaphore+0xff/0x1ec
 [<c0222395>] acpi_ut_acquire_mutex+0xd5/0x170
 [<c0210d27>] acpi_hw_clear_acpi_status+0x57/0xe0
 [<c0211b99>] acpi_enter_sleep_state+0xcd/0x2a8

Oops. Thanks for the report. We'll fix that.

Regards -- Andy
