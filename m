Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267347AbTAQAz4>; Thu, 16 Jan 2003 19:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267348AbTAQAz4>; Thu, 16 Jan 2003 19:55:56 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:51216 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267347AbTAQAzz>;
	Thu, 16 Jan 2003 19:55:55 -0500
Date: Thu, 16 Jan 2003 17:04:16 -0800
From: Greg KH <greg@kroah.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Migrating net/sched to new module interface
Message-ID: <20030117010416.GB2388@kroah.com>
References: <20030115063349.A1521@almesberger.net> <20030116013125.ACE0F2C0A3@lists.samba.org> <20030115234258.E1521@almesberger.net> <3E26F6DC.D9150735@linux-m68k.org> <20030116155815.A29595@almesberger.net> <3E2745E8.D8908505@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E2745E8.D8908505@linux-m68k.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2003 at 12:53:12AM +0100, Roman Zippel wrote:
> Hi,
> 
> Werner Almesberger wrote:
> 
> > > You can simplify this. All you need are the following simple functions:
> > >
> > > - void register();
> > > - void unregister();
> > > - int is_registered();
> > > - void inc_usecount();
> > > - void dec_usecount();
> > > - int get_usecount();
> > 
> > I'm not sure if you, you're not changing the semantics.
> 
> See above functions as primitives, which one can use to build any other
> resource management you want.

That same functionality is already present in a kobj for you to use,
instead of rolling your own resource management code. :)

(sorry, I couldn't help myself...)

greg k-h
