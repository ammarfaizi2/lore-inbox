Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262017AbVCNWE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbVCNWE6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 17:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbVCNWDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 17:03:23 -0500
Received: from imap.gmx.net ([213.165.64.20]:11954 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261967AbVCNWA1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 17:00:27 -0500
X-Authenticated: #20450766
Date: Mon, 14 Mar 2005 22:33:02 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: 20050217125028.GK21077@m.safari.iki.fi
cc: linux-kernel@vger.kernel.org
Subject: [lockup] no NMI (was Re: [OOPS] 2.6.10, ReiserFS errors, preempt)
In-Reply-To: <Pine.LNX.4.60.0502172211510.6851@poirot.grange>
Message-ID: <Pine.LNX.4.60.0503142228160.2354@poirot.grange>
References: <20050217134623.GA2236@linux.ensimag.fr>
 <Pine.LNX.4.60.0502172211510.6851@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Feb 2005, Guennadi Liakhovetski wrote:

> Hello
> 
> On Thu, 17 Feb 2005 castet.matthieu@free.fr wrote:
> 
> > > I believe there's unresolved memory corruption bug in bttv...
> > yes I think so, other have also similar problem :
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=110820804010204&w=2
> > http://marc.theaimsgroup.com/?t=110531543900002&r=1&w=2
> > http://www.ussg.iu.edu/hypermail/linux/kernel/0412.3/0881.html
> 
> Ahh... /me stops the memory test after 18 hours without a single error, 
> pulls the card out of my desktop and inserts it back into the experimantal 
> machine. Unfortunately, unlike in other posts you quoted above, I cannot 
> reproduce my Oops. Is anybody working on this?

Well, I did remove the tv-card - and today got a hard lockup. It's a VIA 
A7VI-VM motherboard with a 900MHz Duron, lapic explicitely re-enabled on 
the command-line:

Kernel command line: BOOT_IMAGE=2.6.10 ro root=308 3 lapic nmi_watchdog=2 
console=tty1 console=ttyS0,38400

/proc/interrupts:

NMI:         59

and still it didn't trigger. Why? Going to get 2.6.11.latest now... Was 
2.6.10.

Thanks
Guennadi
---
Guennadi Liakhovetski

