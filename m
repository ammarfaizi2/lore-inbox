Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311255AbSCLUFf>; Tue, 12 Mar 2002 15:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311258AbSCLUF0>; Tue, 12 Mar 2002 15:05:26 -0500
Received: from fmfdns01.fm.intel.com ([132.233.247.10]:38886 "EHLO
	calliope1.fm.intel.com") by vger.kernel.org with ESMTP
	id <S311255AbSCLUFI>; Tue, 12 Mar 2002 15:05:08 -0500
Message-ID: <794826DE8867D411BAB8009027AE9EB913D03D23@FMSMSX38>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Jonathan A. Davis'" <davis@jdhouse.org>, walter <walt@nea-fast.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: oracle rmap kernel version
Date: Tue, 12 Mar 2002 12:04:57 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Depends on your hardware configuration and how you stress your system with
db workload, you should consider some performance patch from the linux
scalability effort project.
http://lse.sourceforge.net


-----Original Message-----
From: Jonathan A. Davis [mailto:davis@jdhouse.org]
Sent: Tuesday, March 12, 2002 10:35 AM
To: walter
Cc: linux-kernel@vger.kernel.org
Subject: Re: oracle rmap kernel version


On Tue, 12 Mar 2002, Martin J. Bligh wrote:

> > Does anyone have any production experience running Oracle 8i on Linux?
I've 
> > run it at home, RH 7.2 with vanilla 2.4.16 kernel all IDE drives, and
its 
> > fast. We are replacing our SUN/Oracle 8 servers at work in next couple
of 
> 
> The real answer is to try them and do a benchmark for your particular
> application. Shouldn't take that long .... try the -aa tree too.
> 

I can't speak for -aa, but I can say definitively, DO NOT stay with the
"stock" kernel for oracle applications.  We're using -rmap here (mostly 9i
with some 8 scattered around) and performance under moderate and heavy
load is an order of magnitude better.

-- 

-Jonathan <davis@jdhouse.org>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
