Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289004AbSBIQEe>; Sat, 9 Feb 2002 11:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289007AbSBIQEZ>; Sat, 9 Feb 2002 11:04:25 -0500
Received: from paule.demon.co.uk ([158.152.178.86]:16644 "HELO
	paule.demon.co.uk") by vger.kernel.org with SMTP id <S289004AbSBIQEO>;
	Sat, 9 Feb 2002 11:04:14 -0500
Date: Sat, 9 Feb 2002 16:04:07 +0000
From: paule@ilu.vu
To: Chris Ball <chris@void.printf.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3com pcmcia modules.
Message-ID: <20020209160407.A1222@ilu.vu>
In-Reply-To: <20020209151533.A644@ilu.vu> <877kpmvetv.fsf@lexis.house.pkl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <877kpmvetv.fsf@lexis.house.pkl.net>; from chris@void.printf.net on Sat, Feb 09, 2002 at 03:45:48PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 09, 2002 at 03:45:48PM +0000, Chris Ball wrote:
> >>>>> "paule" == paule  <paule@ilu.vu> writes:
> 
>     paule> Apologies if this has been brought up before, but whatever
>     paule> happened to the 3c575 (3com pcmcia) card driver/module in
>     paule> 2.5.x branch? (it was in 2.2.19 for sure).
> 
> In the case of my laptop's Boomerang card, it's now 3c59x; which
> supports all of the 3Com CardBus adaptors.
> 
> More info on Don Becker's site: http://www.scyld.com/network/vortex.html
> 

Thanks for the help,
problem (under 2.5.3) however,

root@paule:/lib/modules/2.5.3/kernel/drivers/net# insmod 3c59x
Using /lib/modules/2.5.3/kernel/drivers/net/3c59x.o
/lib/modules/2.5.3/kernel/drivers/net/3c59x.o: unresolved symbol 
del_timer_sync

Which would probably be why it isnt loaded at boot time either :(

Any help would be appreciated.

-- 
Paul Edwards
