Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313060AbSGTIcA>; Sat, 20 Jul 2002 04:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313628AbSGTIcA>; Sat, 20 Jul 2002 04:32:00 -0400
Received: from bdsl.66.13.29.10.gte.net ([66.13.29.10]:22912 "EHLO
	bluesong.NET") by vger.kernel.org with ESMTP id <S313060AbSGTIb7> convert rfc822-to-8bit;
	Sat, 20 Jul 2002 04:31:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: "Jack F. Vogel" <jfv@bluesong.net>
Reply-To: jfv@bluesong.net
To: Robert Sinko <RSinko@island.com>,
       "'Matt_Domsch@Dell.com'" <Matt_Domsch@Dell.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Wrong CPU count
Date: Sat, 20 Jul 2002 01:38:23 -0700
User-Agent: KMail/1.4.1
References: <628900C9F8A7D51188E000A0C9F3FDFA024FF096@S-NY-EXCH01>
In-Reply-To: <628900C9F8A7D51188E000A0C9F3FDFA024FF096@S-NY-EXCH01>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207200138.23996.jfv@bluesong.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 July 2002 01:07 pm, Robert Sinko wrote:
> Matt,
>
> Thanks for the reply. First, let me say thank you very much for a super web
> site that helped us sort out issues with the 2650 RAID stuff.
>
> I'm not familiar with the HyperThreading concept.
>
> Do you know of any docs that discuss this.  I'm particularly concerned with
> how this impacts the results of monitoring tools such as top.
>
> Thanks,
> Bob

Take a look at www.intel.com and search for Hyperthreading, should find
an article that will help... 

Dont know what 'impact' you're concerned about, top will report the
two instruction units as two processors and show you what they 
are doing.

Long as you run a kernel with the appropriate support in it you'll 
be fine :)

> -----Original Message-----
> From: Matt_Domsch@Dell.com [mailto:Matt_Domsch@Dell.com]
> Sent: Thursday, July 18, 2002 4:01 PM
> To: RSinko@island.com; linux-kernel@vger.kernel.org
> Subject: RE: Wrong CPU count
>
> > After upgrading  from kernel 2.4.7-10smp to 2.4.9-34smp using
> > the Red Hat
> > RPM downloaded from RH Network, the CPU count on the machine
> > reported by
> > dmesg and listed in /proc/cpuinfo was 4 rather than the actual 2.
> >
> > This has occured on all 4 Dell 2650's that I've installed
> > this patch on.  I
> > don't have any other mult-processor machines available to
> > test this with.
>
> Congratulations, you purchased a fine PowerEdge 2650 with processors which
> contain HyperThreading technology.  Each physical processor appears as two
> logical processors.  This behaviour is expected, and correct. :-)



-- 
Jack F. Vogel		IBM Linux Technology Center
jfv@us.ibm.com (work)  ||  jfv@bluesong.net (home)
