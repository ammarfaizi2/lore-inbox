Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317102AbSHAVRX>; Thu, 1 Aug 2002 17:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317115AbSHAVRX>; Thu, 1 Aug 2002 17:17:23 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:50417 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317102AbSHAVRW>; Thu, 1 Aug 2002 17:17:22 -0400
Subject: Re: [PATCH] solved APM bug with -rc5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Willy TARREAU <willy@w.ods.org>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020801211732.GA429@pcw.home.local>
References: <Pine.LNX.4.44.0208010336330.1728-100000@freak.distro.conectiva>
	<20020801121205.GA168@pcw.home.local> <20020801133202.GA200@pcw.home.local>
	<1028213732.14865.50.camel@irongate.swansea.linux.org.uk>
	<20020801135623.GA19879@alpha.home.local>
	<20020801152459.GA19989@alpha.home.local>
	<1028220826.14865.69.camel@irongate.swansea.linux.org.uk>
	<20020801203520.GA244@pcw.home.local>
	<200208012052.g71KqG311998@vindaloo.ras.ucalgary.ca>
	<200208012054.g71Ks8t12065@vindaloo.ras.ucalgary.ca> 
	<20020801211732.GA429@pcw.home.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 01 Aug 2002 23:37:36 +0100
Message-Id: <1028241456.14865.103.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-01 at 22:17, Willy TARREAU wrote:
> On Thu, Aug 01, 2002 at 02:54:08PM -0600, Richard Gooch wrote:
> > Richard Gooch writes:
> > > Hm. I bet you didn't try this with CONFIG_PREEMPT=y, right? IIRC, the
> > > wonderful world of preemption means that you can get rescheduled on
> > > another CPU without warning, unless you take a lock or explicitely
> > > disable preemption.
> > 
> > Apologies. I forgot that CONFIG_PREEMPT is a 2.5.x feature, and
> > doesn't exist on 2.4 (thankfully).
> 
> Never mind, your comment is interesting anyway because it shows that
> preemption patch for 2.4 needs to adapt to such updates.

Pre-emption for 2.4 needs to do a lot of work on raid and even athlon
compiles to fix the FPU stuff, let alone corner cases

