Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263792AbUBHVhK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 16:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264137AbUBHVhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 16:37:10 -0500
Received: from hermes.py.intel.com ([146.152.216.3]:39344 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S263792AbUBHVhI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 16:37:08 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [Infiniband-general] Getting an Infiniband access layer in theLinux kernel
Date: Sun, 8 Feb 2004 13:36:02 -0800
Message-ID: <F595A0622682C44DBBE0BBA91E56A5ED1C3692@orsmsx410.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Infiniband-general] Getting an Infiniband access layer in theLinux kernel
Thread-Index: AcPuYPuy5QhihwWUT9iuPRIpI3aR2wAKZNyA
From: "Woodruff, Robert J" <woody@co.intel.com>
To: "Greg KH" <greg@kroah.com>, "Fab Tillier" <ftillier@infiniconsys.com>
Cc: "Hefty, Sean" <sean.hefty@intel.com>, "Troy Benjegerdes" <hozer@hozed.org>,
       <infiniband-general@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Feb 2004 21:36:02.0630 (UTC) FILETIME=[8CC82E60:01C3EE8B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, February 08, 2004 8:30 AM, Greg KH wrote, 
>Why do you want to run your code in both places?  Does this mean that
it doesn't even really >need to be in the kernel as it works just fine
in userspace?

The reason the Access Layer runs in both kernel and user space is to
support
both kernel and user-mode infiniband clients. For example, in kernel
mode a 
SCSI (SRP) or IPoIB driver would use the Access Layer services. In user
space, a
middleware library, such as DAPL, would use the user-mode access layer
to 
access the infiniband fabric. 

