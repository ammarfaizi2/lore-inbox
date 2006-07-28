Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161203AbWG1SHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161203AbWG1SHV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 14:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161208AbWG1SHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 14:07:20 -0400
Received: from zcars04e.nortel.com ([47.129.242.56]:42938 "EHLO
	zcars04e.nortel.com") by vger.kernel.org with ESMTP
	id S1161203AbWG1SHT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 14:07:19 -0400
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Areca arcmsr kernel integration
Date: Fri, 28 Jul 2006 14:07:12 -0400
Message-ID: <25E284CCA9C9A14B89515B116139A94D0C6DF1A4@zrtphxm0.corp.nortel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Areca arcmsr kernel integration
Thread-Index: AcaycKZh+x+8QyiDS6++0G1spZHIVw==
From: "Theodore Bullock" <tbullock@nortel.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It would be really nice to see the arcmsr driver integrated into the
mainline kernel in the nearish future.

Ideally, the driver would be available before the next major
distribution is published so that the hardware can be officially
supported by the distribution developers eg. Novell, Red Hat, Canonical
... etc.

After a brief review of upcoming schedules, Fedora Core looks to be
updated next in October with the last test release currently scheduled
for October. After that it will probably be SuSE.

We have a good number of workstations with this hardware here, but
support isn't available from our distribution.

Checking the recent posts it seems that there are two outstanding issues

> - PAE (cast of dma_addr_t to unsigned long) issues. 
> - SYNCHRONIZE_CACHE is ignored.  This is wrong.  The sync cache in the

> shutdown notifier isn't sufficient.

That said, we have been using an older version of the driver off the
Areca website for some time now with no major issues (other than kernel
update problems). 

Is it possible to get the driver integrated and fix these problems
after?

Ted Bullock
Nortel Networks
