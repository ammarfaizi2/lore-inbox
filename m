Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268691AbRHTShl>; Mon, 20 Aug 2001 14:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268342AbRHTShd>; Mon, 20 Aug 2001 14:37:33 -0400
Received: from buserror-extern.convergence.de ([212.84.236.66]:28684 "EHLO
	jupiter") by vger.kernel.org with ESMTP id <S268691AbRHTShV>;
	Mon, 20 Aug 2001 14:37:21 -0400
Date: Mon, 20 Aug 2001 20:21:08 +0200
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
Cc: Milind <dmilind@india.hp.com>, linux-kernel@vger.kernel.org,
        blore-linux@yahoogroups.com
Subject: Re: Info about /dev/kmem required
Message-ID: <20010820202108.A7121@jupiter>
In-Reply-To: <3B7D232B.FEA189AD@india.hp.com> <20010817175739.I19385@arthur.ubicom.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010817175739.I19385@arthur.ubicom.tudelft.nl>
User-Agent: Mutt/1.3.18i
From: Frank Neuber <neuber@convergence.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2001 at 05:57:39PM -0400, Erik Mouw wrote:
> On Fri, Aug 17, 2001 at 07:29:08PM +0530, Milind wrote:
> > I wanted some info about ' /dev/kmem ' file with respect to following
> > 
> > 1)  What this file contains?
> 
> >From Documentation/devices.txt:
> 
>   1 char        Memory devices
>                   1 = /dev/mem          Physical memory access
>                   2 = /dev/kmem         Kernel virtual memory access
> 
> > 2)  Who  writes into this file?
> 
> Normally nobody does, though it can be used to patch up a running
> system (in theory).
> 
> > Reply at the earliest.
> 
> I'm sorry, we're not a helpdesk.

I think You can use /dev/kmem as an corefile for gdb. So it is possible to debug
the linux kernel (of course read only :-)).

 Frank
-- 
Dipl.-Ing. Elektrotechnik     convergence integrated media gmbh / HW
Frank Neuber                        Rosenthalerstr.51 / 10178 Berlin
Email:  neuber@convergence.de           Phone:  +49(0)30-72 62 06 50
WWW:    www.convergence.de              Fax:    +49(0)30-72 62 06 55
