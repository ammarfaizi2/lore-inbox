Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932832AbWFVHwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932832AbWFVHwF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 03:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932833AbWFVHwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 03:52:05 -0400
Received: from mga03.intel.com ([143.182.124.21]:48274 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932832AbWFVHwE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 03:52:04 -0400
X-IronPort-AV: i="4.06,164,1149490800"; 
   d="scan'208"; a="55784610:sNHT23205994"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.17-mm1 - possible recursive locking detected
Date: Thu, 22 Jun 2006 03:51:51 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6CF0D03@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.17-mm1 - possible recursive locking detected
Thread-Index: AcaV0G0m+yiw/O6oToe0AhJBk788eQAACbZw
From: "Brown, Len" <len.brown@intel.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <michal.k.k.piotrowski@gmail.com>, <mingo@elte.hu>,
       <arjan@linux.intel.com>, <linux-kernel@vger.kernel.org>,
       <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>
X-OriginalArrivalTime: 22 Jun 2006 07:51:56.0894 (UTC) FILETIME=[BC255FE0:01C695D0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>> The key thing here is that our recent changes in
>> how the locks are _used_ is okay -- and I think it is.
>
>Well.  We don't know that.  We just know that this report of unokayness
>wasn't right.  With Ingo's Linux-only patch we're in a 
>position to verify
>that the locking is probably OK.

If this were really recursive, my machine would have deadlocked
instead of booting normally like it did, no?

-Len
