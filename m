Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266615AbUG0V1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266615AbUG0V1y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 17:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266630AbUG0V1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 17:27:54 -0400
Received: from posti5.jyu.fi ([130.234.4.34]:4265 "EHLO posti5.jyu.fi")
	by vger.kernel.org with ESMTP id S266615AbUG0V1w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 17:27:52 -0400
Date: Wed, 28 Jul 2004 00:27:26 +0300 (EEST)
From: Pasi Sjoholm <ptsjohol@cc.jyu.fi>
X-X-Sender: ptsjohol@silmu.st.jyu.fi
To: Robert Olsson <Robert.Olsson@data.slu.se>
cc: Francois Romieu <romieu@fr.zoreil.com>,
       H?ctor Mart?n <hector@marcansoft.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, <akpm@osdl.org>,
       <netdev@oss.sgi.com>, <brad@brad-x.com>, <shemminger@osdl.org>
Subject: Re: ksoftirqd uses 99% CPU triggered by network traffic (maybe
 RLT-8139 related)
In-Reply-To: <16646.47585.814327.628319@robur.slu.se>
Message-ID: <Pine.LNX.4.44.0407272348590.13195-100000@silmu.st.jyu.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Spam-Checked: by miltrassassin
	at posti5.jyu.fi; Wed, 28 Jul 2004 00:27:29 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2004, Robert Olsson wrote:

>  > Yeah, when the ksoftirqd is taking all the cpu it will be like that, but 
>  > when the kernel is behaving normally the starving diff is between 0->1sec.
>  Well ksoftirqd makes your kernel load just visible which is good and 
>  ksofirqd gets accounted for this when softirq's get deferred to it.
>  It may look like goes from 0 to 100% but thats probably not the case.
>  The problem is we can starve userland at high loads. As said we were
>  trying some way to cure this I may have some old patch if you like to try.

Ok, as I said before I'm willing to test your patches. 

It would be nice that one could use the full capacity of his/her computer.
This is not a big problem for everyday use for a workstation but prevents 
2.6-series to be used in production-enviroments in the servers.
But hey.. we need to do some work and maybe we will resolve this. =)

--
Pasi Sjöholm



