Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261644AbSJUVDo>; Mon, 21 Oct 2002 17:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261642AbSJUVDn>; Mon, 21 Oct 2002 17:03:43 -0400
Received: from [64.114.5.49] ([64.114.5.49]:32528 "EHLO c2kosmtp.cucbc.com")
	by vger.kernel.org with ESMTP id <S261624AbSJUVDl> convert rfc822-to-8bit;
	Mon, 21 Oct 2002 17:03:41 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: FusionMPT in 2.4.18
Date: Mon, 21 Oct 2002 14:09:17 -0700
Message-ID: <38FF1187FD1C714F956F723270D108530BA25B@c2kmail.cucbc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: FusionMPT in 2.4.18
Thread-Index: AcJ5RixsIwai2eT7EdaiS5q6gfEPqg==
From: "Michael Thorpe" <MThorpe@cucbc.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Oct 2002 21:09:56.0468 (UTC) FILETIME=[350F9340:01C27946]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I'm a first-time poster. Please be kind if I break any rules. )

I'm currently trying to build a 2.4.18 kernel for an IBM X335 server.  My primary problem concerns the onboard MPT-Fusion based SCSI controller.

I've gotten this much info so far from /proc/scsi/sg (sg seems to attached to the controller when the modules loads)

/proc/scsi/sg/host_strs: ioc): LSI53C1030, FwRev=01000e00h, Ports=1, MaxQ=222,IRQ=22
/proc/scsi/sg/version: 30122    Version: 3.1.22 (20011208)

Anyhow, I've gotten this controller to work using a "modules" disk I found for SuSE 7.3 hidden somewhere on IBM's site (I'm embarssed to say I've forgotten where).

The mptbase.o and mptscsi.o files provided by this disk seem completely different from the modules that get compiled in the stock 2.4.18 kernel.

Could anyone provide me with any info on this? Or maybe even possibly a patch for 2.4.18 ? My biggest problem is that the modules (obviously) will not allow booting off the controller, so I'd like to be able to used a compiled in kernel driver..

I've currently built a bootdisk with an initrd that allows me to insert the modules and then kick the system, but this is not a very good solution.

Cheers,
Mike

--
Mike Thorpe <mthorpe@cucbc.com>
Linux System Admin



