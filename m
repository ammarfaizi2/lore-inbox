Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317096AbSHAUzP>; Thu, 1 Aug 2002 16:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317110AbSHAUzP>; Thu, 1 Aug 2002 16:55:15 -0400
Received: from ns.suse.de ([213.95.15.193]:22533 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317096AbSHAUzO>;
	Thu, 1 Aug 2002 16:55:14 -0400
Date: Thu, 1 Aug 2002 22:58:42 +0200
From: Dave Jones <davej@suse.de>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Willy TARREAU <willy@w.ods.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] solved APM bug with -rc5
Message-ID: <20020801225842.A24283@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Richard Gooch <rgooch@ras.ucalgary.ca>,
	Willy TARREAU <willy@w.ods.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0208010336330.1728-100000@freak.distro.conectiva> <20020801121205.GA168@pcw.home.local> <20020801133202.GA200@pcw.home.local> <1028213732.14865.50.camel@irongate.swansea.linux.org.uk> <20020801135623.GA19879@alpha.home.local> <20020801152459.GA19989@alpha.home.local> <1028220826.14865.69.camel@irongate.swansea.linux.org.uk> <20020801203520.GA244@pcw.home.local> <200208012052.g71KqG311998@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200208012052.g71KqG311998@vindaloo.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Thu, Aug 01, 2002 at 02:52:16PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2002 at 02:52:16PM -0600, Richard Gooch wrote:
 > > diff -urN linux-2.4.19-rc5/arch/i386/kernel/apm.c linux-2.4.19-rc5-fix/arch/i386/kernel/apm.c
 > > --- linux-2.4.19-rc5/arch/i386/kernel/apm.c	Thu Aug  1 22:07:39 2002
 > > +++ linux-2.4.19-rc5-fix/arch/i386/kernel/apm.c	Thu Aug  1 22:26:56 2002
 > 
 > Hm. I bet you didn't try this with CONFIG_PREEMPT=y, right? IIRC, the
 > wonderful world of preemption means that you can get rescheduled on
 > another CPU without warning, unless you take a lock or explicitely
 > disable preemption.

It's a 2.4 patch. Leave preemption problems to those insane
enough to run 2.4+preempt.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
