Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267410AbTBFVYm>; Thu, 6 Feb 2003 16:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267412AbTBFVYm>; Thu, 6 Feb 2003 16:24:42 -0500
Received: from [81.2.122.30] ([81.2.122.30]:41991 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267410AbTBFVYl>;
	Thu, 6 Feb 2003 16:24:41 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302062132.h16LWtTn002739@darkstar.example.net>
Subject: Re: gcc -O2 vs gcc -Os performance
To: mbligh@aracnet.com (Martin J. Bligh)
Date: Thu, 6 Feb 2003 21:32:55 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
In-Reply-To: <263740000.1044563891@[10.10.2.4]> from "Martin J. Bligh" at Feb 06, 2003 12:38:11 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> All done with gcc-2.95.4 (Debian Woody). These machines (16x NUMA-Q) have 
> >> 700MHz P3 Xeons with 2Mb L2 cache ... -Os might fare better on celeron 
> >> with a puny cache if someone wants to try that out
> > 
> > gcc 3.2 is a lot smarter about -Os and it makes a very big size
> > difference according to the numbers the from the ACPI guys.
> > 
> > Im not sure testing with a gcc from the last millenium is useful 8)
> 
> Still no use.
> /me throws gcc-3.2 in the trash can.

What submodel options are you using?  If you're compiling with
-march=i386, I wouldn't expect -Os to have much effect.

Note that, of all architectures, GCC is almost certainly most
efficient on IA-32.  Although I haven't done any benchmarks against
other compilers on $arch!=IA32, the ones I've seen claim that the
native compiler generates much better code.

John.
