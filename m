Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbVFQTnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbVFQTnt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 15:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbVFQTnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 15:43:03 -0400
Received: from ccerelbas04.cce.hp.com ([161.114.21.107]:38031 "EHLO
	ccerelbas04.cce.hp.com") by vger.kernel.org with ESMTP
	id S262079AbVFQTkf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 15:40:35 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] cciss 2.6: pci domain info
Date: Fri, 17 Jun 2005 14:40:16 -0500
Message-ID: <D4CFB69C345C394284E4B78B876C1CF107DC07D8@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] cciss 2.6: pci domain info
Thread-Index: AcVzc6n+D96KE65NQyiCfL8x8w4nawAAIcyg
From: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
To: "Christoph Hellwig" <hch@infradead.org>
Cc: <akpm@osdl.org>, <axboe@suse.de>, <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 17 Jun 2005 19:40:17.0604 (UTC) FILETIME=[63B39040:01C57374]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph wrote:
> 
> On Fri, Jun 17, 2005 at 01:31:24PM -0500, mike.miller@hp.com wrote:
> > This patch adds pci domain info to our CCISS_GETPCIINFO 
> ioctl. This is to support the next generation of Itanium 
> platforms. We had a couple of spare bytes in the structure. 
> Impact to existing apps should be minimal. Please consider 
> this patch for inclusion.
> 
> I don't think an unsigned int fits into padding of any platform.

How about 'unsigned short' as Willy suggested?

mikem
