Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267260AbSLRPCr>; Wed, 18 Dec 2002 10:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267263AbSLRPCr>; Wed, 18 Dec 2002 10:02:47 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:27367
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267260AbSLRPCr>; Wed, 18 Dec 2002 10:02:47 -0500
Subject: Re: Intel P6 vs P7 system call performance
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@transmeta.com>
In-Reply-To: <1040189657.1562.11.camel@ixodes.goop.org>
References: <Pine.LNX.4.44.0212170948380.2702-100000@home.transmeta.com> 
	<1040189657.1562.11.camel@ixodes.goop.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 18 Dec 2002 15:50:53 +0000
Message-Id: <1040226653.24530.6.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-18 at 05:34, Jeremy Fitzhardinge wrote:
> The P4 optimisation guide promises horrible things if you write within
> 2k of a cached instruction from another CPU (it dumps the whole trace
> cache, it seems), so you'd need to be careful about mixing mutable data
> and the syscall code in that page.

The PIII errata promise worse things with SMP and code modified as
another cpu ruins it and seems to mark them WONTFIX, so there is another
dragon to beware of

