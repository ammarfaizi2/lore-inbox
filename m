Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289367AbSBJKAJ>; Sun, 10 Feb 2002 05:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289467AbSBJJ76>; Sun, 10 Feb 2002 04:59:58 -0500
Received: from paule.demon.co.uk ([158.152.178.86]:36100 "HELO
	paule.demon.co.uk") by vger.kernel.org with SMTP id <S289367AbSBJJ7o>;
	Sun, 10 Feb 2002 04:59:44 -0500
Date: Sun, 10 Feb 2002 09:59:40 +0000
From: paule@ilu.vu
To: Andrew Morton <akpm@zip.com.au>
Cc: Chris Ball <chris@void.printf.net>, linux-kernel@vger.kernel.org
Subject: Re: 3com pcmcia modules.
Message-ID: <20020210095940.A1147@ilu.vu>
In-Reply-To: <20020209151533.A644@ilu.vu> <877kpmvetv.fsf@lexis.house.pkl.net>, <877kpmvetv.fsf@lexis.house.pkl.net>; <20020209160407.A1222@ilu.vu> <3C6584F3.D571C1CB@zip.com.au> <20020209220805.A383@ilu.vu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020209220805.A383@ilu.vu>; from paule@ilu.vu on Sat, Feb 09, 2002 at 10:08:05PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 09, 2002 at 10:08:05PM +0000, paule@ilu.vu wrote:
> On Sat, Feb 09, 2002 at 12:22:11PM -0800, Andrew Morton wrote:
> > paule@ilu.vu wrote:
> > > 
> > > root@paule:/lib/modules/2.5.3/kernel/drivers/net# insmod 3c59x
> > > Using /lib/modules/2.5.3/kernel/drivers/net/3c59x.o
> > > /lib/modules/2.5.3/kernel/drivers/net/3c59x.o: unresolved symbol
> > > del_timer_sync
> > 
> > That can't happen :)
> > 
> 
> reconfigured kernel, re-made, and reconfigured rc.inet1 (under 
> slackware8.0) to support multiple interfaces,
> and now it's all happy! *yay* :)
> (yes im being sick, and using a screen-less laptop to route
>  two internal networks, but hey, it's less than 1u, and cheaper
>  than a router :)
> 

An old problem has re-appeared since I have done this,
On a soft-reboot ('reboot / shutdown -r now') the kernel
stops on its way back up stating
Socket Status 0x0000003

(or something similar)
and it then requires a hard-reset to clear.
This only seems to be under the 3c59x code / more-so the vortex module.

Any help would be appreciated.

Cheers,
