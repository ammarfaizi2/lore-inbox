Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWBQBjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWBQBjq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 20:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbWBQBjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 20:39:46 -0500
Received: from fmr18.intel.com ([134.134.136.17]:5813 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750703AbWBQBjq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 20:39:46 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH][TRIVIAL] Documentation: Fix typo in cputopology.txt
Date: Fri, 17 Feb 2006 09:39:34 +0800
Message-ID: <99FA2ED298A9834DB1BF5DE8BDBF241325BE72@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][TRIVIAL] Documentation: Fix typo in cputopology.txt
thread-index: AcYzSEI6aiDRQH1UQ02ORE8JYNq36AAGotqQ
From: "Zhang, Yanmin" <yanmin.zhang@intel.com>
To: "Jesper Juhl" <jesper.juhl@gmail.com>, <linux-kernel@vger.kernel.org>
Cc: "Trivial Patch Monkey" <trivial@kernel.org>
X-OriginalArrivalTime: 17 Feb 2006 01:39:36.0290 (UTC) FILETIME=[0278FC20:01C63363]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>-----Original Message-----
>>From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Jesper Juhl
>>Sent: 2006Äê2ÔÂ17ÈÕ 6:26
>>To: linux-kernel@vger.kernel.org
>>Cc: Trivial Patch Monkey
>>Subject: [PATCH][TRIVIAL] Documentation: Fix typo in cputopology.txt
>>
>>Fix a small typo in Documentation/cputopology.txt
>>
>>Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
>>---
>>
>> Documentation/cputopology.txt |    2 +-
>> 1 files changed, 1 insertion(+), 1 deletion(-)
>>
>>--- linux-2.6.16-rc3-git7/Documentation/cputopology.txt~	2006-02-16 21:11:11.000000000 +0100
>>+++ linux-2.6.16-rc3-git7/Documentation/cputopology.txt	2006-02-16 21:11:12.000000000 +0100
>>@@ -12,7 +12,7 @@
>> represent the thread siblings to cpu X in the same physical package;
>>
>> To implement it in an architecture-neutral way, a new source file,
>>-driver/base/topology.c, is to export the 5 attributes.
>>+drivers/base/topology.c, is to export the 5 attributes.
Could you also change "5" to "4"? The final patch was accepted into 2.6.16-rc3 only exported 4 attributes.

Thanks,
Yanmin
