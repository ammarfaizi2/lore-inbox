Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315278AbSEGBbI>; Mon, 6 May 2002 21:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315279AbSEGBbH>; Mon, 6 May 2002 21:31:07 -0400
Received: from [24.80.72.250] ([24.80.72.250]:48149 "EHLO neural.parvan.net")
	by vger.kernel.org with ESMTP id <S315278AbSEGBbH> convert rfc822-to-8bit;
	Mon, 6 May 2002 21:31:07 -0400
Subject: REPOSTING: vm: detecting age of page
Date: Mon, 6 May 2002 18:30:50 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <22C8433D3EEC964DB1E84A293A42774B040776@neural.parvan.net>
Content-Transfer-Encoding: 7BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: REPOSTING: vm: detecting age of page
content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0
Thread-Index: AcH1ZtIimafOPFavTHa93loWadtRGQ==
From: "Reza Roboubi" <reza@parvan.net>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(My sincere apologies for reposting.  I forgot to type in a subject.)


I read the following about the /proc/sys/vm/swapctl values:

 * If the page was used since the last time we scanned, its age is
increased by sc_page_advance (default 3). Where the maximum value is
given by sc_max_page_age (default 20).  

 * Otherwise (meaning it wasn't used) its age is decreased by
sc_page_decline (default 1).  

Question:
How can the intel hardware detect page access if the page is mapped into
the process' VM(and resident in RAM)?  If detecting such access is
impossible, then how does kswapd decide the page "age" in this case?

