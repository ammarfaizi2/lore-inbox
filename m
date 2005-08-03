Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261637AbVHCOaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbVHCOaZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 10:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbVHCO2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 10:28:11 -0400
Received: from [202.125.86.130] ([202.125.86.130]:60653 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S262158AbVHCO1C convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 10:27:02 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: 2.6 partition support driver methods 
Date: Wed, 3 Aug 2005 19:53:01 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Message-ID: <C349E772C72290419567CFD84C26E0170423A6@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6 partition support driver methods 
thread-index: AcWYNtpnsQWaLNl2SQqzTYaqHC4drQ==
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: "linux-kernel-Mailing-list" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I have a driver implemented to support single partition in 2.6 kernels.
I have a requirement of supporting multiple partitions in my block driver to support flash media devices.
I have modified the alloc_disk(1) to alloc_dosk(16) to support a MAX of 16 partitions. This way I have conveyed it to the kernel that 16 is my max n/o partitions. I also made a call to add_disk().

Do I need to handle any thing in the request function to handle read/writes to the device partitions?
Please suggest me the required implementation that I may be missing?

Regards,
Mukund Jampala
 

