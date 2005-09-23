Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbVIWRPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbVIWRPO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 13:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbVIWRPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 13:15:14 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:17339 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750825AbVIWRPM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 13:15:12 -0400
Date: Fri, 23 Sep 2005 10:15:14 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: sean.bruno@dsl-only.net, ak@suse.de, LKML <linux-kernel@vger.kernel.org>
Subject: Re: The system works (2.6.14-rc2): functional k8n-dl
Message-ID: <20050923171514.GF5910@us.ibm.com>
References: <20050922155254.GE5910@us.ibm.com> <433303A9.6050909@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <433303A9.6050909@tmr.com>
X-Operating-System: Linux 2.6.14-rc2 (x86_64)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.09.2005 [15:19:05 -0400], Bill Davidsen wrote:
> Nishanth Aravamudan wrote:
> >Hello all,

<snip my long mail>

> >code in such a solid state. I have had only one complaint so far: it
> >seems that the the "Broadcom Corporation NetXtreme BCM5751 Gigabit
> >Ethernet PCI Express" adapter, with the tg3 driver, downs and ups the
> >iface on MTU changes. Unfortunately, with some VPN software I use, it is
> >sometimes necessary to drop the MTU to 1300 or so to get consistent
> >connections. When I do this, though, ssh through the tunnel tends to not
> >function. I have a workaround, where I bounce over a different laptop,
> >but that's a bit of a pain (and that network adapter seems to be able to
> >transiently change the MTU). Not a big deal, in any case.
> 
> You can (or could in 2.4) sometimes play with the size for an individual 
> IP by using the "mss" option of the old "route" command. That shouldn't 
> glitch anything, it just should use little packets.

Yes, I see that still being an option. Let me go learn how to use route
and see if that works better.

Thanks,
Nish
