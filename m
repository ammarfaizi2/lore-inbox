Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261891AbVCAMgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbVCAMgX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 07:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbVCAMgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 07:36:23 -0500
Received: from magic.adaptec.com ([216.52.22.17]:7104 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S261887AbVCAMgT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 07:36:19 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [2.6 patch] SCSI: possible cleanups
Date: Tue, 1 Mar 2005 07:36:15 -0500
Message-ID: <60807403EABEB443939A5A7AA8A7458BD63E10@otce2k01.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6 patch] SCSI: possible cleanups
Thread-Index: AcUd5KS5mtbsAL4OQ3i6XZbN+IgeAgAdDlnA
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "Christoph Hellwig" <hch@infradead.org>, "Adrian Bunk" <bunk@stusta.de>
Cc: <James.Bottomley@SteelEye.com>, <linux-scsi@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, "Mark Haverkamp" <markh@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:
>>   - scsi_scan.c: scsi_rescan_device
>aacraid was going to use that one, Mark, any chance to get a patch
anytime soon?
>>   - scsi_scan.c: scsi_scan_single_target
>as mentioned above we'll need this one soon.

Yup, we use both of them in our branch of the driver. I submit a patch
to MarkH for the Hot-Add calls soon.

Sincerely -- Mark Salyzyn

