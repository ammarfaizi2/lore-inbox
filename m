Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315707AbSECU4t>; Fri, 3 May 2002 16:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315709AbSECU4r>; Fri, 3 May 2002 16:56:47 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:2821 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S315705AbSECU4j>;
	Fri, 3 May 2002 16:56:39 -0400
Date: Fri, 3 May 2002 22:56:35 +0200
From: Jens Axboe <axboe@suse.de>
To: Sebastian Droege <sebastian.droege@gmx.de>
Cc: dalecki@evision-ventures.com, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH] IDE TCQ #2
Message-ID: <20020503225635.A27281@suse.de>
In-Reply-To: <20020503110652.GF839@suse.de> <20020503163248.633c8358.sebastian.droege@gmx.de> <20020503164555.GQ839@suse.de> <20020503185744.7f4e192f.sebastian.droege@gmx.de> <20020503170118.GV839@suse.de> <20020503193006.6b4b9094.sebastian.droege@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
X-OS: Linux 2.2.20 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03 2002, Sebastian Droege wrote:
> On Fri, 3 May 2002 19:01:18 +0200
> Jens Axboe <axboe@suse.de> wrote:
> 
> > > > > ide_tcq_intr_timeout: timeout waiting for interrupt...
> > > > > ide_tcq_intr_timeout: hwgroup not busy
> > > > 
> > > > We timed out waiting for an interrupt for service or dma completion.
> > > > Damn, I forgot to print which one. Please change that printk in
> > > > drivers/ide/ide-tcq.c:ide_tcq_intr_timeout() to:
> > > > 
> > > > 	printk("ide_tcq_intr_timeout: timeout waiting for %s interrupt...\n",
> > > > 		hwgroup->rq ? "completion" : "service");
> > > > 
> > > > and reproduce!
> > > Is this printk enough or should I handcopy the oops again? ;)
> > 
> > The oops is pretty irrelevant here, the fact that it triggers is enough
> > to know. I already know the backtrace :-)
> 
> It's a service interrupt....

Ok thanks, what were the other messages this time? Just the ones before
the oops.

Jens

