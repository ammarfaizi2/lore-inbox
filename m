Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933082AbWFZWCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933082AbWFZWCm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933075AbWFZWCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:02:42 -0400
Received: from mga03.intel.com ([143.182.124.21]:20121 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S933080AbWFZWCk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:02:40 -0400
X-IronPort-AV: i="4.06,178,1149490800"; 
   d="scan'208"; a="57691530:sNHT7662249238"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch] ACPI: reduce code size, clean up, fix validator message
Date: Mon, 26 Jun 2006 17:58:08 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6D8C62C@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] ACPI: reduce code size, clean up, fix validator message
Thread-Index: AcaZXJ3kZmobwYZvRiqBF6dz2aJ1OQADu5fw
From: "Brown, Len" <len.brown@intel.com>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: "Pavel Machek" <pavel@ucw.cz>, "Andrew Morton" <akpm@osdl.org>,
       <michal.k.k.piotrowski@gmail.com>, <arjan@linux.intel.com>,
       <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
       "Moore, Robert" <robert.moore@intel.com>,
       "Arjan van de Ven" <arjan@infradead.org>
X-OriginalArrivalTime: 26 Jun 2006 21:58:11.0060 (UTC) FILETIME=[9D8F4340:01C6996B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>( for example the ACPI practice of allocating opaque 'handler' 
> pointers that carry no type at [they are void *] is playing with fire.
It in 
> essence disables the remaining little bit of type-safety 
> that C has. )

I agree 100%.

-Len
