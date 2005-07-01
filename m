Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263389AbVGAQyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263389AbVGAQyY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 12:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263395AbVGAQyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 12:54:23 -0400
Received: from ccerelbas04.cce.hp.com ([161.114.21.107]:40682 "EHLO
	ccerelbas04.cce.hp.com") by vger.kernel.org with ESMTP
	id S263389AbVGAQyS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 12:54:18 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 1/1] cciss per disk queue for 2.6
Date: Fri, 1 Jul 2005 11:53:33 -0500
Message-ID: <D4CFB69C345C394284E4B78B876C1CF107DC0869@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/1] cciss per disk queue for 2.6
Thread-Index: AcV+XOnoHsiqyELrTGmuZ2dzsY86ZwAADRKw
From: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
To: "Jens Axboe" <axboe@suse.de>
Cc: <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 01 Jul 2005 16:53:33.0476 (UTC) FILETIME=[6A8F4640:01C57E5D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> Different thing, I'm talking about single volume starvation, 
> not volume-to-volume.
> 
> > elevator algoritm(s) may be causing writes to starve reads 
> on the same 
> > logical volume. We continue to investigate our other 
> performance issues.
> 
> I completely disagree. Even with an intelligent io scheduler, 
> starvation is seen on ciss that does not happen on other 
> queueing hardware such as 'normal' scsi controllers/drives. 
> So something else is going on, and the only 'fix' so far is 
> to limit the ciss queue depth heavily.

We will investigate this further and come up with a solution. Could be
the firmware, I suppose.

mikem

> 
> --
> Jens Axboe
> 
> 
