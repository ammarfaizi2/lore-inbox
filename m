Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264346AbUHWNuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264346AbUHWNuQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 09:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264371AbUHWNuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 09:50:16 -0400
Received: from [202.125.86.130] ([202.125.86.130]:18415 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S264346AbUHWNuK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 09:50:10 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Support for HIGHMEM ...can any one explain my Q&A .. 
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Mon, 23 Aug 2004 19:21:22 +0530
Message-ID: <4EE0CBA31942E547B99B3D4BFAB348110B1385@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Support for HIGHMEM ...can any one explain my Q&A .. 
Thread-Index: AcSJFmI+u4Qp6wiGSzKZkoa8i6vKRAAAIisg
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,
Sorry if I asked any thing that basic level stuff?
This is the paasge I found in the net while surfing for details about
HIGHMEM stuff.

During 2.3 kernel development (I think), "HIGHMEM" support was added.
Normally, the kernel can only address (4GB-PAGE_OFFSET)/PAGE_SIZE pages
of RAM, since all physical pages must be mapped to kernel addresses
between PAGE_OFFSET and 4GB. (So if PAGE_OFFSET is 3GB, only 1GB of
physical RAM can be used - not even that, in practice, due to fixed
kernel mappings and so forth.) The HIGHMEM patches allow the kernel to
use more than 1G of memory by mapping the additional pages into the high
part of the kernel address space just below 4GB as necessary. They also
allow high-memory pages to be mapped into user process address space.


***) Does the above passage mean that PAGE_OFFSET is the starting
address of my RAM ?
I understood so from the below line
"since all physical pages must be mapped to kernel addresses between
PAGE_OFFSET and 4GB".

***) Does it mean that the lowest portion of the 4GB os nothing but RAM
?

thanks in advance Guys,

regards,
Mukund Jampala

