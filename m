Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267355AbTBFQmG>; Thu, 6 Feb 2003 11:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267356AbTBFQmG>; Thu, 6 Feb 2003 11:42:06 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:10655
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267355AbTBFQmF>; Thu, 6 Feb 2003 11:42:05 -0500
Subject: Re: gcc -O2 vs gcc -Os performance
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <224770000.1044546145@[10.10.2.4]>
References: <336780000.1044313506@flay>  <224770000.1044546145@[10.10.2.4]>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044553691.10374.20.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 06 Feb 2003 17:48:13 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-06 at 15:42, Martin J. Bligh wrote:
> All done with gcc-2.95.4 (Debian Woody). These machines (16x NUMA-Q) have 
> 700MHz P3 Xeons with 2Mb L2 cache ... -Os might fare better on celeron 
> with a puny cache if someone wants to try that out

gcc 3.2 is a lot smarter about -Os and it makes a very big size
difference according to the numbers the from the ACPI guys.

Im not sure testing with a gcc from the last millenium is useful 8)

