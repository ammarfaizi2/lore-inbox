Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbVDFCwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbVDFCwM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 22:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVDFCwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 22:52:12 -0400
Received: from wip-ec-wd.wipro.com ([203.101.113.39]:57011 "EHLO
	wip-ec-wd.wipro.com") by vger.kernel.org with ESMTP id S262085AbVDFCwH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 22:52:07 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Scheduling tasklets from process context...
Date: Wed, 6 Apr 2005 08:20:28 +0530
Message-ID: <8F94FD7C111E3D43BA3C7CF89CB50E92012AA7B5@BLR-EC-2K3MSG.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Scheduling tasklets from process context...
Thread-Index: AcU5o2nE/voz6U0GTVKOrkpf1wqXXw==
From: <arun.prabha@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 06 Apr 2005 02:55:38.0093 (UTC) FILETIME=[1C9221D0:01C53A54]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I have a query.

Since tasklets are typically used for bottom half
processing, is it acceptable/recommended that they
be scheduled from a process context (say an ioctl handler)?

Should one try to minimize such scheduling and try to
do things in process context if possible, as tasklets run
in interrupt context? Or is the driver writer free to use
the tasklets at will? What is recommended here?

Thanks in advance,
Arun.
