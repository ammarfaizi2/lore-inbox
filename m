Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271808AbTGXWzd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 18:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271810AbTGXWzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 18:55:33 -0400
Received: from dsl093-172-075.pit1.dsl.speakeasy.net ([66.93.172.75]:32139
	"EHLO marta.kurtwerks.com") by vger.kernel.org with ESMTP
	id S271808AbTGXWzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 18:55:20 -0400
Date: Thu, 24 Jul 2003 19:10:08 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: Douglas J Hunley <doug@hunley.homeip.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0: Badness in pci_find_subsys!!
Message-ID: <20030724231008.GB28205@kurtwerks.com>
References: <200307241326.04656.doug@hunley.homeip.net> <20030724173526.GA7952@kroah.com> <200307241347.08124.doug@hunley.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307241347.08124.doug@hunley.homeip.net>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.21-krw
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoth Douglas J Hunley:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Greg KH shocked and awed us all by speaking:
> > On Thu, Jul 24, 2003 at 01:26:01PM -0400, Douglas J Hunley wrote:
> > > Just had my athlon box lock-up solid. needed SysRq to reboot the thing..
> > > kernel info follows:
> > > Jul 24 13:08:23 doug kernel: Badness in pci_find_subsys at
> > > drivers/pci/search.c:132
> > > Jul 24 13:08:23 doug kernel: Call Trace:
> > > Jul 24 13:08:23 doug kernel:  [<c02064a1>] pci_find_subsys+0x111/0x120
> > > Jul 24 13:08:23 doug kernel:  [<c02064df>] pci_find_device+0x2f/0x40
> > > Jul 24 13:08:23 doug kernel:  [<c0206368>] pci_find_slot+0x28/0x50
> > > Jul 24 13:08:23 doug kernel:  [<f8a2ada4>] os_pci_init_handle+0x3a/0x67
> > > [nvidia]
> >
> > You are using the nvidia driver.  Go complain to them as we can do
> > nothing about their code, sorry.
> 
> sure. I didn't know for sure that the fault was nvidia's.

Do you get the same lock up *sans* the nvidia binary-only module?

Kurt
-- 
I am so optimistic about beef prices that I've just leased a pot roast
with an option to buy.
