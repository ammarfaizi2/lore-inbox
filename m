Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266879AbUIOQzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266879AbUIOQzT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 12:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266539AbUIOQzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 12:55:18 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:56776 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266821AbUIOQyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 12:54:54 -0400
Subject: Re: swapping and the value of /proc/sys/vm/swappiness
From: Florin Andrei <florin@andrei.myip.org>
Reply-To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
In-Reply-To: <20040914201558.GA32254@logos.cnet>
References: <413CB661.6030303@sgi.com>
	 <cone.1094512172.450816.6110.502@pc.kolivas.org>
	 <20040906162740.54a5d6c9.akpm@osdl.org>
	 <1095186713.6309.15.camel@stantz.corp.sgi.com>
	 <20040914201558.GA32254@logos.cnet>
Content-Type: text/plain
Message-Id: <1095267281.17153.14.camel@stantz.corp.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 15 Sep 2004 09:54:42 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-14 at 13:15, Marcelo Tosatti wrote:
> On Tue, Sep 14, 2004 at 11:31:53AM -0700, Florin Andrei wrote:

> > I've found a situation where the vanilla kernel has a behaviour that
> > makes no sense:
> > 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=109237941331221&w=2
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=109237959719868&w=2
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=109238126314192&w=2
> > 
> > A patch by Con Kolivas fixed it:
> > 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=109410526607990&w=2
> > 
> > I cannot offer more details, i have no time for experiments, i just need
> > a system that works. The vanilla kernel does not.
> 
> Have you tried to decrease the value of /proc/sys/vm/swappiness 
> to say 30 and see what you get?

I cannot repeat the experiment (due to lack of time) but i remember
having severe issues with low /proc/*/swappiness values on vanilla
kernels. I don't recall the nature of the problems, though, because it's
been a while. Sorry. But that was what prompted me to search further.
The search ended when i found and tested Con's patch.

The current swapping policy of the vanilla 2.6 kernels is broken. Badly.

At least my system works properly now. <shrug>

-- 
Florin Andrei

http://florin.myip.org/

