Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136525AbRD3WMW>; Mon, 30 Apr 2001 18:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136524AbRD3WML>; Mon, 30 Apr 2001 18:12:11 -0400
Received: from alcove.wittsend.com ([130.205.0.20]:28310 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S135920AbRD3WME>; Mon, 30 Apr 2001 18:12:04 -0400
Date: Mon, 30 Apr 2001 18:10:56 -0400
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Francois Gouget <fgouget@free.fr>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Elmer Joandi <elmer@linking.ee>,
        Ookhoi <ookhoi@dds.nl>, linux-kernel@vger.kernel.org
Subject: Re: Aironet doesn't work
Message-ID: <20010430181056.A10487@alcove.wittsend.com>
Mail-Followup-To: Francois Gouget <fgouget@free.fr>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Elmer Joandi <elmer@linking.ee>, Ookhoi <ookhoi@dds.nl>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3AEDB0D4.2CB47196@mandrakesoft.com> <Pine.LNX.4.21.0104301319570.30974-100000@amboise.dolphin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.2i
In-Reply-To: <Pine.LNX.4.21.0104301319570.30974-100000@amboise.dolphin>; from fgouget@free.fr on Mon, Apr 30, 2001 at 01:22:59PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	I'm tunning into this discussion a little late, but...

On Mon, Apr 30, 2001 at 01:22:59PM -0700, Francois Gouget wrote:
> On Mon, 30 Apr 2001, Jeff Garzik wrote:

> > Francois Gouget wrote:
> > > CONFIG_PCMCIA=y
> > > CONFIG_CARDBUS=y
> > > CONFIG_I82365=y
> > 
> > Not correct -- you do not need I82365 if you have CardBus.  However, if
> > you are running 2.4.4 you should be ok.

>    Ok. I upgraded to 2.4.4 and modified my config file to be:

> CONFIG_PCMCIA=y
> CONFIG_CARDBUS=y
> # CONFIG_I82365 is not set

>    But now I get the same missing symbols I initially had in 2.4.3:

> Apr 30 13:19:34 oleron cardmgr[148]: initializing socket 0
> Apr 30 13:19:34 oleron cardmgr[148]: socket 0: Aironet PC4800
> Apr 30 13:19:34 oleron cardmgr[148]: executing: 'modprobe aironet4500_core'
> Apr 30 13:19:34 oleron cardmgr[148]: + Warning: /lib/modules/2.4.4/kernel/drivers/net/aironet4500_core.o 
> symbol for parameter rx_queue_len not found
> Apr 30 13:19:34 oleron cardmgr[148]: executing: 'modprobe aironet4500_proc'
> Apr 30 13:19:34 oleron cardmgr[148]: executing: 'modprobe aironet4500_cs'
> Apr 30 13:19:35 oleron cardmgr[148]: get dev info on socket 0
> failed: Resource temporarily unavailable

	Seen this before.  What version are your modutils at?  Latest are
2.4.5 on kernel.org and there have been several times where I've had
them slip out of rev and ended up with missing symbols.

> --
> Francois Gouget         fgouget@free.fr        http://fgouget.free.fr/
>                             1 + e ^ ( i * pi ) = 0

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

