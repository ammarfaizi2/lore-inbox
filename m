Return-Path: <linux-kernel-owner+willy=40w.ods.org-S317500AbUKBExq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S317500AbUKBExq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 23:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S378062AbUKAWm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 17:42:28 -0500
Received: from hqemgate00.nvidia.com ([216.228.112.144]:12552 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S273529AbUKAUfE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 15:35:04 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: NForce3 SATA badness with remove/add devices 
Date: Mon, 1 Nov 2004 12:35:02 -0800
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B00287BF0F@hqemmail02.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: NForce3 SATA badness with remove/add devices 
thread-index: AcS+3jlKLPiwKkraS6mxuZXVrqcsywBc7YNA
From: "Andrew Chew" <AChew@nvidia.com>
To: "Michael Thonke" <TK-SHOCKWAVE@web.de>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 01 Nov 2004 20:35:02.0529 (UTC) FILETIME=[437C5710:01C4C052]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> its my 3 attemp (LKML Post 0410.2/0129l) to get a answer to 
> following thing. First of all I'm using a NForce 3 250GB (MSI 
> K8N Neo2 Platinum) With 3 SATA disks Maxtor  6B200M/NCQ 
> 2xSamsung SP1213C
> 
> My Problem is when the kernel starts with libsata and sata_nv 
> compiled in when I boot the System with libsata and sata_nv 
> it removes the first disk (Maxtor 6B200B) then a abnormal 
> timeout occur while adding the device: this message appears 
> error is "ATA: abnormal status 0x0D on port 0x9E7" and "ata 
> is to slow to answer" now the corious thing on that is if I 
> wait 40 or 50 sec maybe it work or maybe not.. when I'm using 
> the old "CONFIG_BLK_DEV_IDE_SATA:" everything works great 
> here. I dont know whats wrong but i tested it on 5 Motherboard 
> there the Maxtor working without hicks (VIA 
> KT880Pro,i875P,i925,SIS755,Promise 378 SATA TX2, but when I 
> plug it on a NForce 3 250GB (MSI K8N Neo2 or Gigabyte K8NSNXP 
> or even new MSI K8N Neo2) 
> the same timeout occur..the Maxtor 6B200M is SATA2 but full 
> SATA compatible. 
> I thought it is because of hotplug support but disabling all 
> this stuff did not work. I hope someone know why this happen 
> and how to fix this.

Can you try the workaround suggested in
http://bugme.osdl.org/show_bug.cgi?id=3352?
