Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbUC3VkK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 16:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUC3VkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 16:40:10 -0500
Received: from mailout.zma.compaq.com ([161.114.64.103]:39172 "EHLO
	zmamail03.zma.compaq.com") by vger.kernel.org with ESMTP
	id S261273AbUC3VkD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 16:40:03 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: HSG80 entry in drivers/scsi/scsi_scan.c
Date: Tue, 30 Mar 2004 16:40:00 -0500
Message-ID: <A8B003DDA3332A479C0ECCA641F47E6503BE66F5@tayexc13.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: HSG80 entry in drivers/scsi/scsi_scan.c
Thread-Index: AcQWn42MgaWVNX6tTz+f4e9hB7l5gw==
From: "Dupuis, Chad" <chad.dupuis@hp.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 30 Mar 2004 21:40:00.0969 (UTC) FILETIME=[8DE91390:01C4169F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I wanted to report that the 

{"DEC","HSG80","*", BLIST_FORCELUN | BLIST_NOSTARTONADD},

entry in the device_list[] structure in drivers/scsi/scsi_scan.c is
incorrect.  It should be

{"DEC","HSG80","*", BLIST_SPARSELUN | BLIST_LARGELUN |
BLIST_NOSTARTONADD}

Thank you,

Chad Dupuis
Hewlett-Packard Company



