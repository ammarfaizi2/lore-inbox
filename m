Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261972AbSIYNEw>; Wed, 25 Sep 2002 09:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261973AbSIYNEv>; Wed, 25 Sep 2002 09:04:51 -0400
Received: from hercules.egenera.com ([208.254.46.135]:45067 "HELO
	coyote.egenera.com") by vger.kernel.org with SMTP
	id <S261972AbSIYNEv>; Wed, 25 Sep 2002 09:04:51 -0400
Date: Wed, 25 Sep 2002 09:07:22 -0400
From: Phil Auld <pauld@egenera.com>
To: DragonK <dragon_krome@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel 2.4.x Bug
Message-ID: <20020925090722.K4368@vienna.EGENERA.COM>
References: <20020924213421.22776.qmail@web20307.mail.yahoo.com> <200209250709.g8P79ip29724@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200209250709.g8P79ip29724@Port.imtp.ilyichevsk.odessa.ua>; from vda@port.imtp.ilyichevsk.odessa.ua on Wed, Sep 25, 2002 at 10:04:05AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rumor has it that on Wed, Sep 25, 2002 at 10:04:05AM -0200 Denis Vlasenko said:
> On 24 September 2002 19:34, DragonK wrote:
> > I'm sorry if I'm sending this to the wrong persons,
> > but I really don't know whom I should send this to.
> >
> > My problem involves ALL linux kernels 2.4.x. All
> > versions I've tried on my machine lock up at boot time
> > (no panic, no oops, just plain old dead), just after
> > writing "Uncompressing linux kernel...Ok, now booting
> > the kernel...". The kernel banner DOES NOT appear. I
> > compiled every kernel with a minimal set of options
> > (and CPU=386) but nothing; I've even installed the
> > latest Lilo.

maybe too minimal :)

This sounds like what you get if you don't have VT configured. 
Make sure you have these in your .config

CONFIG_VT=y
CONFIG_VT_CONSOLE=y

Phil
