Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315272AbSEGBH0>; Mon, 6 May 2002 21:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315274AbSEGBHZ>; Mon, 6 May 2002 21:07:25 -0400
Received: from [24.80.72.250] ([24.80.72.250]:21269 "EHLO neural.parvan.net")
	by vger.kernel.org with ESMTP id <S315272AbSEGBHZ> convert rfc822-to-8bit;
	Mon, 6 May 2002 21:07:25 -0400
Subject: 
Date: Mon, 6 May 2002 18:07:03 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <22C8433D3EEC964DB1E84A293A42774B0222FE@neural.parvan.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
content-class: urn:content-classes:message
Thread-Index: AcH1Y3/iQxO2448RSSyCd6uCtjvmXw==
X-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0
From: "Reza Roboubi" <reza@parvan.net>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I read the following about the /proc/sys/vm/swapctl values:

 * If the page was used since the last time we scanned, its age is
increased by sc_page_advance (default 3). Where the maximum value is
given by sc_max_page_age (default 20).  

 * Otherwise (meaning it wasn't used) its age is decreased by
sc_page_decline (default 1).  

How can the intel hardware detect page access if the page is mapped into
the process VM(and resident in RAM)?  If detecting such access is
impossible, then how does kswapd decide the page "age" in this case?
