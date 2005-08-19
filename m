Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932546AbVHSI7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546AbVHSI7d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 04:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbVHSI7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 04:59:33 -0400
Received: from [202.125.80.34] ([202.125.80.34]:14121 "EHLO mail.esn.co.in")
	by vger.kernel.org with ESMTP id S932546AbVHSI7c convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 04:59:32 -0400
Content-class: urn:content-classes:message
Subject: Fix to Linux FAT12 mount issue?
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Fri, 19 Aug 2005 14:23:11 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Message-ID: <3AEC1E10243A314391FE9C01CD65429B38E4@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Fix to Linux FAT12 mount issue?
Thread-Index: AcWkm22JV2+kZAaLSz6Xs/9lGWAGtA==
From: "Mukund JB`." <mukundjb@esntechnologies.co.in>
To: "linux-kernel-Mailing-list" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

Its time that there should be a fix applied to the FAT12 subsystem in
Linux.
I have noted that removable device FAT12 formatted in Camera like
digital media does NOT have the FAT12 in sector 0 instead it has a
partition table that speaks about the FAT12 fs start sector.

Such devices that do NOT have the file system in sector 0 instead have
the partition table are failing to mount under Linux.
Why is it so?

I have even tested USB mounted device suspecting the in-built
card-reader driver I am using?

Even it fails.
Who has to handle this? which layer?

Regards,
Mukund Jampala
