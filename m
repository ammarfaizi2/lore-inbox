Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261353AbSLMEvh>; Thu, 12 Dec 2002 23:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261354AbSLMEvh>; Thu, 12 Dec 2002 23:51:37 -0500
Received: from wiprom2mx2.wipro.com ([203.197.164.42]:58496 "EHLO
	wiprom2mx2.wipro.com") by vger.kernel.org with ESMTP
	id <S261353AbSLMEvg> convert rfc822-to-8bit; Thu, 12 Dec 2002 23:51:36 -0500
x-mimeole: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [BENCHMARK] short summary of LM bench performance of mm2 patch
Date: Fri, 13 Dec 2002 10:29:11 +0530
Message-ID: <94F20261551DC141B6B559DC4910867201DF05@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BENCHMARK] short summary of LM bench performance of mm2 patch
Thread-Index: AcKiZGAISLpte7/zQFmN1VDZpI/mCA==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Josh Fryman" <fryman@cc.gatech.edu>
X-OriginalArrivalTime: 13 Dec 2002 04:59:11.0983 (UTC) FILETIME=[608937F0:01C2A264]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Josh, please comment on the format.
Here is a short summary of performance of 2.5.51 mm2 as compared to 2.5.51 mm1 on LM bench. Figures below are 'median' of 5 results.

-------------------------------------------------------------------------------
For detailed results, please mail me so that I will send results individually.
-------------------------------------------------------------------------------

								2.5.51 mm1		2.5.51-mm2
==================================================================================
Processor, Processes - times in microseconds - smaller is better

1. Null call time decreased a bit.			0.46			0.44
2. increase in time for fork proc 			362			403
----------------------------------------------------------------------------------
Context switching - times in microseconds - smaller is better

1. 2p/16K ctxsw						5.01			4.84
----------------------------------------------------------------------------------
*Local* Communication latencies in microseconds - smaller is better
1. UDP							33			35
2. TCP							122			125
----------------------------------------------------------------------------------
File & VM system latencies in microseconds - smaller is better
1. 10K file delete					57			59
2. mmap latency						615			651
==================================================================================

Rest of the results are not much different.
	

Regards,
Aniruddha Marathe
WIPRO technologies, India
Aniruddha.marathe@wipro.com			
+91-80-5502001 extn 5092
