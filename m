Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWHBWV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWHBWV7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 18:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbWHBWV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 18:21:59 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:32459 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932279AbWHBWV6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 18:21:58 -0400
In-Reply-To: <20060802.151906.21953222.davem@davemloft.net>
To: David Miller <davem@davemloft.net>
Cc: catalin.marinas@gmail.com, cxzhang@watson.ibm.com, czhang.us@gmail.com,
       jmorris@namei.org, linux-kernel@vger.kernel.org,
       michal.k.k.piotrowski@gmail.com, netdev@vger.kernel.org,
       sds@tycho.nsa.gov
Subject: Re: [Patch] kernel memory leak fix for af_unix datagram getpeersec patch
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 7.0 HF144 February 01, 2006
Message-ID: <OFB994A805.0392D443-ON852571BE.007AA6ED-852571BE.007ADA31@us.ibm.com>
From: Xiaolan Zhang <cxzhang@us.ibm.com>
Date: Wed, 2 Aug 2006 18:21:51 -0400
X-MIMETrack: Serialize by Router on D01ML605/01/M/IBM(Release 7.0.1HF269 | June 22, 2006) at
 08/02/2006 18:21:54,
	Serialize complete at 08/02/2006 18:21:54
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see.  The build was fine under x86 and there are so many warnings that a 
-Werror probably won't work for me.

thanks,
Catherine

David Miller <davem@davemloft.net> wrote on 08/02/2006 06:19:06 PM:

> From: Xiaolan Zhang <cxzhang@us.ibm.com>
> Date: Wed, 2 Aug 2006 18:18:07 -0400
> 
> > I did test it with CONFIG_SECURITY disabled, but did not catch the 
warning 
> > -- I verified that the build completes with a valid vmlinux image. 
There 
> > are many warnings (device drivers, and others) during the build and I 
> > didn't do a grep to find which one is specific to my patch.  Next time 

> > I'll do a diff on warnings too.
> 
> Some platforms build their platform code under arch/${ARCH}/foo with
> -Werror added to CFLAGS, sparc64 is one such platform.  So the build
> did break for me.

