Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265071AbUD3GVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265071AbUD3GVj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 02:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265081AbUD3GVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 02:21:39 -0400
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:61712 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S265071AbUD3GVh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 02:21:37 -0400
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>, brettspamacct@fastclick.com,
       linux-kernel@vger.kernel.org
From: Tim Connors <tconnors+linuxkernel1083305837@astro.swin.edu.au>
Subject: Re:  ~500 megs cached yet 2.6.5 goes into swap hell 
In-reply-to: <200404292001.i3TK1BYe005147@eeyore.valparaiso.cl>
References: <40904A84.2030307@yahoo.com.au> <200404292001.i3TK1BYe005147@eeyore.valparaiso.cl>
X-Face: +*%dmR:3=9i\[:8fga\UgZT#@`f=DU0(wQqI'AR2/r0sBMO}Ax\,V*cWaW-owRlUmuz&=v\KItx0:gRCBg1&z_"4x&-N#Di7))]~p2('`6|5.c3&:Z?VLU`Zt5Kb,~uC6<y}P'~7A+^'|'+iAd4t43:P;tPiT<q=9P$MO]u^@OHn1_4#qP7,XiSo21SkgI`:5=i$,t&uNN_\LfuLyH`)8!:Tb]Z
Message-ID: <slrn-0.9.7.4-14292-10175-200404301617-tc@hexane.ssi.swin.edu.au>
Date: Fri, 30 Apr 2004 16:20:18 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand <vonbrand@inf.utfsm.cl> said on Thu, 29 Apr 2004 16:01:11 -0400:
> Nick Piggin <nickpiggin@yahoo.com.au> said:
> 
> [...]
> 
> > I don't know. What if you have some huge application that only
> > runs once per day for 10 minutes? Do you want it to be consuming
> > 100MB of your memory for the other 23 hours and 50 minutes for
> > no good reason?
> 
> How on earth is the kernel supposed to know that for this one particular
> job you don't care if it takes 3 hours instead of 10 minutes, just because
> you don't want to spare enough preciousss RAM?

Note that we are not talking about having insufficient memory. In my
case (2.4 kernel - ie, 2.6 with swapiness 0%) there is more than
enough memory to contain all my working set - it's only because cache
is too eager to claim memory that is otherwise in use that
non-optimalities occur.

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
If I'd known computer science was going to be like this, I'd never have
given up being a rock 'n' roll star.                -- G. Hirst
