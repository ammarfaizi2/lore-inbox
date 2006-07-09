Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932508AbWGIXGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbWGIXGJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 19:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbWGIXGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 19:06:09 -0400
Received: from mga01.intel.com ([192.55.52.88]:27059 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932508AbWGIXGH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 19:06:07 -0400
X-IronPort-AV: i="4.06,221,1149490800"; 
   d="scan'208"; a="95411448:sNHT14419580"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.17-mm2 -- drivers/built-in.o: In function `is_pci_dock_device':acpiphp_glue.c:(.text+0x12364): undefined reference to `is_dock_device'
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Sun, 9 Jul 2006 19:06:01 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6ECF9E8@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.17-mm2 -- drivers/built-in.o: In function `is_pci_dock_device':acpiphp_glue.c:(.text+0x12364): undefined reference to `is_dock_device'
Thread-Index: AcaYl6IJB7gcQznqSa+Cd/5a3RjmngLEVZcQAADCUuA=
From: "Brown, Len" <len.brown@intel.com>
To: "Brown, Len" <len.brown@intel.com>, "Adrian Bunk" <bunk@stusta.de>,
       "Miles Lane" <miles.lane@gmail.com>,
       "Accardi, Kristen C" <kristen.c.accardi@intel.com>
Cc: "Dave Hansen" <haveblue@us.ibm.com>, "Andrew Morton" <akpm@osdl.org>,
       "LKML" <linux-kernel@vger.kernel.org>, <gregkh@suse.de>,
       <linux-acpi@vger.kernel.org>, "Linus Torvalds" <torvalds@osdl.org>
X-OriginalArrivalTime: 09 Jul 2006 23:06:03.0531 (UTC) FILETIME=[404FC5B0:01C6A3AC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fixed typo -- can't cook and type at the same time...

DOCK	HPA
n	n	builds
n	y	-> y,y
n	m	-> m,m
y	n	builds
y	y	builds
y	m	builds
m	n	builds
m	y	-> y,y (previous note had typo, m,y)
m	m	builds
