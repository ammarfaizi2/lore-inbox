Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262297AbVAJPrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbVAJPrQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 10:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262295AbVAJPrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 10:47:16 -0500
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:42246 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S262297AbVAJPpv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 10:45:51 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH 2.6] cciss typo fix
Date: Mon, 10 Jan 2005 09:45:44 -0600
Message-ID: <D4CFB69C345C394284E4B78B876C1CF107DC0188@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6] cciss typo fix
Thread-Index: AcT1Xdn4+asr/rMURwq+l3tFxkbfogBzSFSQ
From: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
To: "Jens Axboe" <axboe@suse.de>
Cc: "James Bottomley" <James.Bottomley@SteelEye.com>,
       "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "SCSI Mailing List" <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 10 Jan 2005 15:45:50.0374 (UTC) FILETIME=[75B61C60:01C4F72B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > -		*block_size = be32_to_cpu(*((__be32 *) 
> > &buf->block_size[0]));
> > > +		*total_size = be32_to_cpu(*((__u32 *) 
> > &buf->total_size[0]))+1;
>


> From: Jens Axboe [mailto:axboe@suse.de]
> Hmm odd, no one should have complained, it should just have been added
> to the compat header.

Even if it were added to the compat header; is using __be32 correct in this context?

mikem
