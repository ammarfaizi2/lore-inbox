Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317997AbSHICWr>; Thu, 8 Aug 2002 22:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318122AbSHICWr>; Thu, 8 Aug 2002 22:22:47 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:35036 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317997AbSHICWq>; Thu, 8 Aug 2002 22:22:46 -0400
Subject: Re: [PATCH] cyclone-timer_A9
From: john stultz <johnstul@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Leah Cunningham <leahc@us.ibm.com>,
       wilhelm.nuesser@sap.com, paramjit@us.ibm.com, msw@redhat.com,
       James Cleverdon <jamesclv@us.ibm.com>
In-Reply-To: <1028812719.28882.34.camel@irongate.swansea.linux.org.uk>
References: <1028771615.22918.188.camel@cog> 
	<1028772956.22920.207.camel@cog> 
	<1028812719.28882.34.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 08 Aug 2002 19:03:37 -0700
Message-Id: <1028858618.1118.7.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-08 at 06:18, Alan Cox wrote:
> On Thu, 2002-08-08 at 03:15, john stultz wrote:
> > Marcelo,
> > 	This patch (which applies on top of my tsc-disable_B9 patch as well as
> > James Cleverdon's summit patch), is a performance improvement for
> > multi-CEC IBM x440 systems which suffer from drifting TSCs. Rather then
> > forcing do_gettimeofday to call do_slow_gettimeoffset and access the PIT
> > (as my tsc-disable patch does), passing "cyclone" as a boot option will
> > make do_gettimeofday use a 100Mhz performance counter found in the
> > Summit chipset.
> 
> Why not probe for the summit chipset ?

Yea, its on my list. Once Jame's patch settles down I plan to piggy back
off that. 

Thanks!
-john
 


