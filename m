Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263786AbTKFTdc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 14:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263787AbTKFTd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 14:33:28 -0500
Received: from [198.70.193.2] ([198.70.193.2]:46420 "EHLO AVEXCH01.qlogic.org")
	by vger.kernel.org with ESMTP id S263786AbTKFTdY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 14:33:24 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b6).
Date: Thu, 6 Nov 2003 11:33:28 -0800
Message-ID: <B179AE41C1147041AA1121F44614F0B0598CEA@AVEXCH02.qlogic.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b6).
Thread-Index: AcOkj+gF5A+Vh7P2Q4WyTG/HmlakdgACNKLQ
From: "Andrew Vasquez" <andrew.vasquez@qlogic.com>
To: <arjanv@redhat.com>
Cc: "Christoph Hellwig" <hch@infradead.org>,
       "Linux-Kernel" <linux-kernel@vger.kernel.org>,
       "Linux-SCSI" <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 06 Nov 2003 19:33:29.0088 (UTC) FILETIME=[DAE63800:01C3A49C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan,

> > No.  We've had this IOWR problem since the inception of 5.x series
> > driver.  Software (SMS 3.0) has been built on top of the this
> > IOCTL
> 
> how about removing most if not all of these ioctls ?  The scsi layer
> has a *generic* "send passthrough" mechanism already for example.
> 

I'm not entirely clear on what you are alluding to here, are you
referring to SCSI_IOCTL_SEND_COMMAND?  There's significantly more
functionality embedded within the IOCTLs than simply sending passthrus
to devices.  Also, all of QLogic's drivers (linux, solaris, windows)
implement to this 'external ioctl' spec, making changes to Linux alone
would difficult.

Regards,
Andrew Vasquez
