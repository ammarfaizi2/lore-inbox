Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261732AbSJZAnl>; Fri, 25 Oct 2002 20:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261742AbSJZAnl>; Fri, 25 Oct 2002 20:43:41 -0400
Received: from 3-090.ctame701-1.telepar.net.br ([200.193.161.90]:62599 "EHLO
	3-090.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261732AbSJZAnk>; Fri, 25 Oct 2002 20:43:40 -0400
Date: Fri, 25 Oct 2002 22:49:16 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Nakajima, Jun" <jun.nakajima@intel.com>, Robert Love <rml@tech9.net>,
       "'Dave Jones'" <davej@codemonkey.org.uk>,
       "'akpm@digeo.com'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'chrisl@vmware.com'" <chrisl@vmware.com>,
       "'Martin J. Bligh'" <mbligh@aracnet.com>
Subject: RE: [PATCH] hyper-threading information in /proc/cpuinfo
In-Reply-To: <1035584076.13032.96.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44L.0210252248240.1697-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Oct 2002, Alan Cox wrote:
> On Fri, 2002-10-25 at 22:50, Nakajima, Jun wrote:

> > Can you please change "siblings\t" to "threads\t\t". SuSE 8.1, for example,
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
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

