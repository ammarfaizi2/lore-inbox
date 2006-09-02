Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWIBBMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWIBBMV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 21:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWIBBMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 21:12:21 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:54608 "EHLO
	asav09.insightbb.com") by vger.kernel.org with ESMTP
	id S1750774AbWIBBMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 21:12:21 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HAFp1+ESBT4lWLA
From: Dmitry Torokhov <dtor@insightbb.com>
To: Grant Coady <gcoady.lk@gmail.com>
Subject: Re: 2.6.18-rc5-mm1
Date: Fri, 1 Sep 2006 21:12:18 -0400
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060901015818.42767813.akpm@osdl.org> <3tkhf2p4f1n1s7ancfmclrlijvne8nhoit@4ax.com>
In-Reply-To: <3tkhf2p4f1n1s7ancfmclrlijvne8nhoit@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609012112.18826.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 September 2006 21:06, Grant Coady wrote:
> On Fri, 1 Sep 2006 01:58:18 -0700, Andrew Morton <akpm@osdl.org> wrote:
> 
> >
> >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc5/2.6.18-rc5-mm1/
> ...
> >- See the `hot-fixes' directory for any important updates to this patchset.
> >
> Okay, I applied hotfixes and it crashed on boot, keyboard LEDs flashing:
> 
> Repeating message, hand copied:
> atkbd.c: Spurious ACK in isa0060/serio0. Some program might be trying access 
> hardware directly.
> 

Please try booting with i8042.panicblink=0 to see the real oops (important
data). We should probably disable blinking if X is not active...

-- 
Dmitry

-- 
VGER BF report: H 2.32592e-14
