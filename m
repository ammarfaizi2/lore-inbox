Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317471AbSHHLzR>; Thu, 8 Aug 2002 07:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317472AbSHHLzR>; Thu, 8 Aug 2002 07:55:17 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:57070 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317471AbSHHLzQ>; Thu, 8 Aug 2002 07:55:16 -0400
Subject: Re: [PATCH] cyclone-timer_A9
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: john stultz <johnstul@us.ibm.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Leah Cunningham <leahc@us.ibm.com>,
       wilhelm.nuesser@sap.com, paramjit@us.ibm.com, msw@redhat.com,
       James Cleverdon <jamesclv@us.ibm.com>
In-Reply-To: <1028772956.22920.207.camel@cog>
References: <1028771615.22918.188.camel@cog> 
	<1028772956.22920.207.camel@cog>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 08 Aug 2002 14:18:39 +0100
Message-Id: <1028812719.28882.34.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-08 at 03:15, john stultz wrote:
> Marcelo,
> 	This patch (which applies on top of my tsc-disable_B9 patch as well as
> James Cleverdon's summit patch), is a performance improvement for
> multi-CEC IBM x440 systems which suffer from drifting TSCs. Rather then
> forcing do_gettimeofday to call do_slow_gettimeoffset and access the PIT
> (as my tsc-disable patch does), passing "cyclone" as a boot option will
> make do_gettimeofday use a 100Mhz performance counter found in the
> Summit chipset.

Why not probe for the summit chipset ?

