Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262067AbSJVDTF>; Mon, 21 Oct 2002 23:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262070AbSJVDTF>; Mon, 21 Oct 2002 23:19:05 -0400
Received: from mail.cscoms.net ([202.183.255.13]:6153 "EHLO csmail.cscoms.com")
	by vger.kernel.org with ESMTP id <S262067AbSJVDTC>;
	Mon, 21 Oct 2002 23:19:02 -0400
Date: Tue, 22 Oct 2002 10:24:45 +0700
From: Alain Fauconnet <alain@cscoms.net>
To: kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org, lve@ns.aanet.ru
Subject: Re: UPD: Frequent/consistent panics in 2.4.19 at ip_route_input_slow, in_dev_get(dev)
Message-ID: <20021022102444.C2361@cscoms.net>
References: <20021021100207.E302@cscoms.net> <200210211640.UAA07235@sex.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200210211640.UAA07235@sex.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Mon, Oct 21, 2002 at 08:40:16PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2002 at 08:40:16PM +0400, kuznet@ms2.inr.ac.ru wrote:
> Hello!
> 
> > much   yet).   My   next   plan is to implement LKCD on the 2.4.17 box
> > (not available for 2.4.19 yet as it  seems)  and  capture  a  complete
> > crash dump. Would that help tracking down?
> 
> I do not think that this will help.
> 
> Try better to enable slab poisoning in slab.h. If it that thing
> which I think of, it would provoke crash.

Thanks for your reply,

Does that mean just enabling CONFIG_DEBUG_SLAB  in  kernel  config  or
more?

I see:

#define SLAB_POISON             0x00000800UL    /* Poison objects */

in slab.h, but there's nothing settable in there.

Anyway I've recompiled the 2.4.19 kernel with CONFIG_DEBUG_SLAB=y.
Let's see what happens.

Greets,
_Alain_
