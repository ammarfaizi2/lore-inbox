Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262825AbUDAKaJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 05:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbUDAKaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 05:30:09 -0500
Received: from [202.125.86.130] ([202.125.86.130]:40621 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S262825AbUDAKaH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 05:30:07 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Flash Media block driver problem!
Date: Thu, 1 Apr 2004 15:53:41 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Message-ID: <1118873EE1755348B4812EA29C55A972176F95@esnmail.esntechnologies.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Flash Media block driver problem!
Thread-Index: AcQX0roRki2hggxwQbm6Fjiph6ZeegAAFvuA
From: "Jinu M." <jinum@esntechnologies.co.in>
To: <arjanv@redhat.com>
Cc: <linux-kernel@vger.kernel.org>,
       "Surendra I." <surendrai@esntechnologies.co.in>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 2004-04-01 at 12:03, Jinu M. wrote:
> Hi All,
> 
> We are developing a block device driver (2.4.x kernel) for Flash Media devices
why?
aren't the existing usb/IDE drivers working for you ??

[jinum] This is not a USB/IDE(ATA)/SCSI based device. The controller is directly mapped to the PCI Bus. So we basically write a device driver like the once which are in drivers/block/*.c (non-IDE).
