Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317510AbSFEALb>; Tue, 4 Jun 2002 20:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317512AbSFEALa>; Tue, 4 Jun 2002 20:11:30 -0400
Received: from [209.184.141.168] ([209.184.141.168]:34428 "HELO UberGeek")
	by vger.kernel.org with SMTP id <S317510AbSFEAL3>;
	Tue, 4 Jun 2002 20:11:29 -0400
Subject: Re: Load kernel module automatically
From: Austin Gonyou <austin@digitalroadkill.net>
To: dmarkh@cfl.rr.com
Cc: Jan Hudec <bulb@ucw.cz>, kernelnewbies@nl.linux.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <3CFD4CCE.9DB9BF52@cfl.rr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 04 Jun 2002 19:11:25 -0500
Message-Id: <1023235885.10519.11.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-06-04 at 18:27, Mark Hounschell wrote:
> Austin Gonyou wrote:
> > 
> > On Tue, 2002-06-04 at 17:27, Jan Hudec wrote:
........
> > > Kernel does not seek for modules to load in any way. Actually, in usual
> > > installation there are tons of modules compiled an mostly unused. You
> > > must put the insmod command (or better modprobe command) somewhere in
> > > the init scripts. Since I expect your installation is RedHat (the kernel
> > > version looks like a RedHat one), there should already be one a it
> > > should be loading all modules listed in /etc/modules.conf (not sure abou
> > > the exact name - I don't have RedHat).
> > 
> > Isn't that what modules.conf (conf.modules on some) is for though? To
> > have lists of available devices and load modules if their services are
> > used?(i.e. ifup eth0, but eth0 doesn't exist at boot time, so ifup calls
> > a utility that loads the module, then ifup continues to run)
> > 
> The utility is built into the kernel, it's called kmod and uses /etc/modules.conf
> as it's config file....

That's all my point was...:) Thanks!


> 
> Mark
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
