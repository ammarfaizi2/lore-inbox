Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268657AbUI2QaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268657AbUI2QaX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 12:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268700AbUI2QaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 12:30:23 -0400
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:33040 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S268657AbUI2QaM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 12:30:12 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: patch so cciss stats are collected in /proc/stat
Date: Wed, 29 Sep 2004 11:29:59 -0500
Message-ID: <D4CFB69C345C394284E4B78B876C1CF107DBFE0B@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: patch so cciss stats are collected in /proc/stat
Thread-Index: AcSmQDUdCSjGzAuSTrqBVH/aV4evDQAAICKw
From: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
To: "Christoph Hellwig" <hch@infradead.org>, <mikem@beardog.cca.cpqcorp.net>
Cc: <marcelo.tosatti@cyclades.com>, <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>,
       "Baker, Brian (ISS - Houston)" <brian.b@hp.com>
X-OriginalArrivalTime: 29 Sep 2004 16:30:00.0228 (UTC) FILETIME=[90997E40:01C4A641]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Wed, Sep 29, 2004 at 11:13:45AM -0500, mike.miller@hp.com wrote:
> > Currently cciss statistics are not collected in /proc/stat. 
> This patch
> > bumps DK_MAX_MAJOR to 111 to fix that. This has been a 
> common complaint
> > by customers wishing to gather info about cciss devices.
> > Please consider this for inclusion. Applies to 2.4.28-pre3.
> 
> This patch has been reject about half a million times, why are people
> submitting it again and again?

As I said in my mail, it's a customer driven issue. As long as customers rely on /proc/stat we'll keep trying. You can't tell a customer how he/she should be doing things on their systems.

mikem
> 
> You get more detailed statistics in /proc/partitions.
> 
> 
