Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318765AbSHLRbc>; Mon, 12 Aug 2002 13:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318766AbSHLRag>; Mon, 12 Aug 2002 13:30:36 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:64782 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318765AbSHLRa1>;
	Mon, 12 Aug 2002 13:30:27 -0400
Date: Mon, 12 Aug 2002 10:30:30 -0700
From: Greg KH <greg@kroah.com>
To: Julien BLACHE <jb@jblache.org>
Cc: Brad Hards <bhards@bigpond.net.au>, Adrian Bunk <bunk@fs.tum.de>,
       linux-kernel@vger.kernel.org, rlievin@free.fr
Subject: Re: [2.5 patch] tiglusb.c must include version.h
Message-ID: <20020812173030.GA15652@kroah.com>
References: <Pine.NEB.4.44.0208111416110.3636-100000@mimas.fachschaften.tu-muenchen.de> <200208121012.59099.bhards@bigpond.net.au> <87znvsmqfx.fsf@frigate.technologeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87znvsmqfx.fsf@frigate.technologeek.org>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Mon, 15 Jul 2002 16:28:30 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2002 at 10:28:18AM +0200, Julien BLACHE wrote:
> Brad Hards <bhards@bigpond.net.au> wrote:
> 
> Hi,
> 
> >> line 44 is:
> >>   #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
> >>
> >>
> >> The fix is simple:
> > <snip>
> >> +#include <linux/version.h>
> >
> > Wouldn't it be cleaner to just remove this case? It is in 2.5, after all.

I agree.

> But if this should become a hassle for anybody, I'll remove this case
> ASAP.

Don't worry about it, I just made the change in my tree, and will send
the change to Linus later today.

thanks,

greg k-h
