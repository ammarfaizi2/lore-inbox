Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263438AbSJJVJ1>; Thu, 10 Oct 2002 17:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263475AbSJJVJ1>; Thu, 10 Oct 2002 17:09:27 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:41119 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263438AbSJJVJ0>;
	Thu, 10 Oct 2002 17:09:26 -0400
Subject: Re: Patch?: linux-2.5.41 multiprocessor vs. CONFIG_X86_TSC
From: john stultz <johnstul@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       "Adam J. Richter" <adam@yggdrasil.com>, mingo@redhat.com,
       James.Bottomley@HansenPartnership.com,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1034284641.6463.26.camel@irongate.swansea.linux.org.uk>
References: <20021010050212.A383@baldur.yggdrasil.com> 
	<20021010121757.GY12432@holomorphy.com>  <1034274158.19093.28.camel@cog> 
	<1034284641.6463.26.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 10 Oct 2002 14:07:27 -0700
Message-Id: <1034284047.19981.43.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-10 at 14:17, Alan Cox wrote:
> On Thu, 2002-10-10 at 19:22, john stultz wrote:
> > Actually, the TSC is only guaranteed to be a valid time source on
> > uniprocessor machines. Linux tries its best to synchronize the TSCs
> > across cpus at boot, however larger systems where all the cups are not
> 
> On a subset of uniprocessor machines...

Ah, very true, good catch. 

thanks
-john

