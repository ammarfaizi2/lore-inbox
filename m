Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbUCJCyl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 21:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbUCJCyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 21:54:40 -0500
Received: from fmr06.intel.com ([134.134.136.7]:10434 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261458AbUCJCy0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 21:54:26 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Kernel 2.6.3 patch for Intel Compiler 8.0
Date: Tue, 9 Mar 2004 18:53:02 -0800
Message-ID: <7F740D512C7C1046AB53446D37200173FEB4C2@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Kernel 2.6.3 patch for Intel Compiler 8.0
Thread-Index: AcQGRPjzp4aA6sj4TqmzFA1w0si+PgABIV3Q
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Norihiko Mukouyama" <norihiko_m@jp.fujitsu.com>,
       "Stefan Smietanowski" <stesmi@stesmi.com>,
       "Norberto Bensa" <norberto+linux-kernel@bensa.ath.cx>
Cc: "Ingo at Pyrillion" <ingo@pyrillion.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 10 Mar 2004 02:53:03.0727 (UTC) FILETIME=[CEA1BFF0:01C4064A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.6, we already have sufficient changes for Intel IPF Compiler to
build the kernel, especially intrinscs changes, and you should not need
a patch. To make it faster, we might want to use PGO (profile guided
optimization) provided by the compiler; yes, it's available even for the
kernel with a driver.

Thanks,
Jun

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
>owner@vger.kernel.org] On Behalf Of Norihiko Mukouyama
>Sent: Tuesday, March 09, 2004 6:08 PM
>To: Stefan Smietanowski; Norberto Bensa
>Cc: Ingo at Pyrillion; linux-kernel@vger.kernel.org
>Subject: RE: Kernel 2.6.3 patch for Intel Compiler 8.0
>
>Hi,Stefan!!
>
>>1/3 of the things are faster with icc. 2/3 of the things are faster
>>with gcc. Performance numbers not given.
>
>Thank you very much.
>I understood that meaning.
>
>By the way,
>
>I would like to learn the result of making his patch run on Itanium2.
>Because, the difference of the performance of the compiler being sure
to
>influence most
>remarkably.
>
>Can  anyone try?
>
>Thanks.
>
>Norihiko
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
