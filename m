Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271850AbSISRKL>; Thu, 19 Sep 2002 13:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271851AbSISRKL>; Thu, 19 Sep 2002 13:10:11 -0400
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:32018 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S271850AbSISRKK> convert rfc822-to-8bit; Thu, 19 Sep 2002 13:10:10 -0400
x-mimeole: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: TPC-C benchmark used standard RH kernel
Date: Thu, 19 Sep 2002 12:15:08 -0500
Message-ID: <45B36A38D959B44CB032DA427A6E106402D09E42@cceexc18.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: TPC-C benchmark used standard RH kernel
Thread-Index: AcJgABq7XsxoI844QG66TWvwVXA2og==
From: "Bond, Andrew" <Andrew.Bond@hp.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 Sep 2002 17:15:09.0233 (UTC) FILETIME=[1B321A10:01C26000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe I need to clarify my earlier posting about kernel features that gave the benchmark a boost.  The kernel that we used in the benchmark was an unmodified Red Hat Advanced Server 2.1 kernel.  We did tune the kernel via standard user space tuning, but the kernel was not patched.  HP, Red Hat, and Oracle have worked closely together to make sure that the features I mentioned were in the Advanced Server kernel "out of the box."

Could we have gotten better performance by patching the kernel?  Sure.  There are many new features in 2.5 that would enhance database performance.  However, the fairly strict support requirements of TPC benchmarking mean that we need to benchmark a kernel that a Linux distributor ships and can support.  
Modifications could also be taken to the extreme, and we could have built a screamer kernel that runs Oracle TPC-C's and nothing else.  However, that doesn't really tell us anything useful and doesn't help those customers thinking about running Linux.  The question also becomes "Who would provide customer support for that kernel?" 

Regards,
Andy

