Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbVCICyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVCICyd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 21:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVCICyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 21:54:32 -0500
Received: from fmr24.intel.com ([143.183.121.16]:14527 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261386AbVCICyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 21:54:31 -0500
Message-Id: <200503090254.j292sGg16842@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Christoph Hellwig'" <hch@infradead.org>
Cc: <linux-kernel@vger.kernel.org>, "'Andrew Morton'" <akpm@osdl.org>,
       "'Jens Axboe'" <axboe@suse.de>
Subject: RE: Direct io on block device has performance regression on 2.6.x kernel - fix sync I/O path
Date: Tue, 8 Mar 2005 18:54:16 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcUkToO9qXy2PmoWSr2edGci2glK8AABJVGQ
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
In-Reply-To: <20050309022002.GA23577@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote on Tuesday, March 08, 2005 6:20 PM
> this is not the blockdevice, but the obsolete raw device driver.  Please
> benchmark and if nessecary fix the blockdevice O_DIRECT codepath insted
> as the raw driver is slowly going away.

>From performance perspective, can raw device be resurrected? (just asking)

- Ken


