Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbWJKKGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWJKKGt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 06:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWJKKGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 06:06:49 -0400
Received: from usea-naimss1.unisys.com ([192.61.61.103]:21265 "EHLO
	usea-naimss1.unisys.com") by vger.kernel.org with ESMTP
	id S1751107AbWJKKGs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 06:06:48 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: FW: FW:  [PATCH 2.6.17.3] Memory Management: High-MemoryScalabilityIssue
Date: Wed, 11 Oct 2006 15:35:34 +0530
Message-ID: <88299102B8C1F54BB5C8E47F30B2FBE204D8631E@inblr-exch1.eu.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: FW:  [PATCH 2.6.17.3] Memory Management: High-MemoryScalabilityIssue
Thread-Index: Acbs+vvMFzj0A3JiRyu73DV1b+oVwAAIa8ng
From: "Satapathy, Soumendu Sekhar" <Soumendu.Satapathy@in.unisys.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 11 Oct 2006 10:05:37.0643 (UTC) FILETIME=[CCBCCBB0:01C6ED1C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



 

-----Original Message-----
From: Andrew Morton [mailto:akpm@osdl.org] 
Sent: Wednesday, October 11, 2006 11:33 AM
To: Satapathy, Soumendu Sekhar
Subject: Re: FW: [PATCH 2.6.17.3] Memory Management:
High-MemoryScalabilityIssue

On Wed, 11 Oct 2006 11:12:32 +0530
"Satapathy, Soumendu Sekhar" <Soumendu.Satapathy@in.unisys.com> wrote:

> Hi,
> 
> Was it possible for you to go through this patch ?
> 

Not yet, but I haven't forgotten.

I suspect the problem has gone away now - in 2.6.19-rc1 we no longer
allow
applications to flood the machine with dirty MAP_SHARED memory.

It'd be useful if you could rerun the test on that kernel.
