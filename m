Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262197AbSJJVAp>; Thu, 10 Oct 2002 17:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262387AbSJJVAp>; Thu, 10 Oct 2002 17:00:45 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:28078 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262216AbSJJVAo>; Thu, 10 Oct 2002 17:00:44 -0400
Subject: Re: Patch?: linux-2.5.41 multiprocessor vs. CONFIG_X86_TSC
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: john stultz <johnstul@us.ibm.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       "Adam J. Richter" <adam@yggdrasil.com>, mingo@redhat.com,
       James.Bottomley@HansenPartnership.com,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1034274158.19093.28.camel@cog>
References: <20021010050212.A383@baldur.yggdrasil.com> 
	<20021010121757.GY12432@holomorphy.com>  <1034274158.19093.28.camel@cog>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Oct 2002 22:17:21 +0100
Message-Id: <1034284641.6463.26.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-10 at 19:22, john stultz wrote:
> Actually, the TSC is only guaranteed to be a valid time source on
> uniprocessor machines. Linux tries its best to synchronize the TSCs
> across cpus at boot, however larger systems where all the cups are not

On a subset of uniprocessor machines...

