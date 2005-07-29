Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262564AbVG2MC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbVG2MC1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 08:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262535AbVG2MC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 08:02:27 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:52748 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S262564AbVG2MCZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 08:02:25 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <C349E772C72290419567CFD84C26E01704201D@mail.esn.co.in>
References: <C349E772C72290419567CFD84C26E01704201D@mail.esn.co.in>
X-OriginalArrivalTime: 29 Jul 2005 12:02:23.0599 (UTC) FILETIME=[614497F0:01C59435]
Content-class: urn:content-classes:message
Subject: Re: Unable to mount the SD card formatted using the DIGITAL CAMREA on Linux box
Date: Fri, 29 Jul 2005 08:02:14 -0400
Message-ID: <Pine.LNX.4.61.0507290757290.12897@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Unable to mount the SD card formatted using the DIGITAL CAMREA on Linux box
thread-index: AcWUNWFq4CfSJ8QVShaTZtqm9S3FRA==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Srinivas G." <srinivasg@esntechnologies.co.in>
Cc: "linux-kernel-Mailing-list" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 29 Jul 2005, Srinivas G. wrote:

> Dear All,
>
> We have developed a Block Device Driver to handle the flash media
> devices in Linux 2.6.x kernel. It is working fine. We are able to mount
> the SD cards that are formatted on Windows systems, but we unable mount
> the cards that are formatted using the DIGITAL CAMERA.
>
> We have found one thing that the Windows and Digital Camera both are
> formatting the SD cards in FAT12 only. But why we are not able to mount
> the SD cards on Linux Box that are formatted using the Digital Camera.
>
> Could any one explain the problem? It is great help to us.
> Thanks in advance and we are looking forward a POSITIVE reply.
>
> Thanks and Regards,
> Srinivas G

Execute linux `fdisk` on the device. You may find that the
ID byte is wrong.

Also, why do you need a special block device driver? The SanDisk
and CompacFlash devices should look like IDE drives.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
