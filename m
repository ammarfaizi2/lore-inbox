Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316072AbSEJRgU>; Fri, 10 May 2002 13:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316074AbSEJRgU>; Fri, 10 May 2002 13:36:20 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:43927 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316072AbSEJRgT>; Fri, 10 May 2002 13:36:19 -0400
Date: Fri, 10 May 2002 10:36:16 -0700 (PDT)
From: Nivedita Singhvi <niv@us.ibm.com>
X-X-Sender: <nivedita@w-nivedita2.des.beaverton.ibm.com>
To: <nharring@hostway.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Tcp/ip offload card driver
Message-ID: <Pine.LNX.4.33.0205101035200.11164-100000@w-nivedita2.des.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Obviously some form of driver is necessary to access the
> device, whether or not we're pushing fully formed IP packets
> or raw payload. Or is that a userland problem and I'm just
> not understanding the flow from userspace through the kernel
> and to the driver properly?

> Cheers,
> Nicholas Harring

Your initial premise seemed to include the offload of TCP
as well. Doesn't that mean:

application -> driver -> card [ creates full TCP/IP pkt ]

TCP is stateful, feature rich and highly configurable.
Do you expect that a fw/hw implementation will provide
an equivalent implementation?  Support for tuning, options,
network taps, diag, bug fixes, feature tweaks, ... ?

Very curious..

thanks,
Nivedita

