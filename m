Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261742AbSJZArs>; Fri, 25 Oct 2002 20:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261745AbSJZArs>; Fri, 25 Oct 2002 20:47:48 -0400
Received: from fmr01.intel.com ([192.55.52.18]:64502 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S261742AbSJZArr>;
	Fri, 25 Oct 2002 20:47:47 -0400
Message-ID: <F2DBA543B89AD51184B600508B68D4000ECE70E1@fmsmsx103.fm.intel.com>
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: Rik van Riel <riel@conectiva.com.br>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>, Robert Love <rml@tech9.net>,
       "'Dave Jones'" <davej@codemonkey.org.uk>,
       "'akpm@digeo.com'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'chrisl@vmware.com'" <chrisl@vmware.com>,
       "'Martin J. Bligh'" <mbligh@aracnet.com>
Subject: RE: [PATCH] hyper-threading information in /proc/cpuinfo
Date: Fri, 25 Oct 2002 17:54:00 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't understand. HT is one implementaion of (true) SMT. 

Thanks,
Jun

-----Original Message-----
From: Rik van Riel [mailto:riel@conectiva.com.br]
Sent: Friday, October 25, 2002 5:49 PM
To: Alan Cox
Cc: Nakajima, Jun; Robert Love; 'Dave Jones'; 'akpm@digeo.com';
'linux-kernel@vger.kernel.org'; 'chrisl@vmware.com'; 'Martin J. Bligh'
Subject: RE: [PATCH] hyper-threading information in /proc/cpuinfo


On 25 Oct 2002, Alan Cox wrote:
> On Fri, 2002-10-25 at 22:50, Nakajima, Jun wrote:

> > Can you please change "siblings\t" to "threads\t\t". SuSE 8.1, for
example,
> > is already doing it:

> Im just wondering what we would then use to describe a true multiple cpu
> on a die x86. Im curious what the powerpc people think since they have
> this kind of stuff - is there a generic terminology they prefer ?

Agreed.  Siblings is probably best for HT stuff and threads
are probably best reserved for true SMT CPUs.

Then there's the SMP-on-a-chip, but we should probably just
call those CPUs.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a
href=mailto:"october@surriel.com">october@surriel.com</a>
