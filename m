Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274813AbRJaWY3>; Wed, 31 Oct 2001 17:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274434AbRJaWYT>; Wed, 31 Oct 2001 17:24:19 -0500
Received: from h55p103-2.delphi.afb.lu.se ([130.235.187.175]:17628 "EHLO gin")
	by vger.kernel.org with ESMTP id <S275082AbRJaWYM>;
	Wed, 31 Oct 2001 17:24:12 -0500
Date: Wed, 31 Oct 2001 23:24:39 +0100
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: andersg@0x63.nu, linux-kernel@vger.kernel.org
Subject: Re: Local APIC option (CONFIG_X86_UP_APIC) locks up Inspiron 8100
Message-ID: <20011031232439.D6285@h55p111.delphi.afb.lu.se>
In-Reply-To: <200110312217.XAA28976@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200110312217.XAA28976@harpo.it.uu.se>
User-Agent: Mutt/1.3.23i
From: andersg@0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2001 at 11:17:16PM +0100, Mikael Pettersson wrote:
> > > The patch is now available at
> > > http://www.csd.uu.se/~mikpe/linux/patch-2.4.13ac5-init-order-5
> > 
> > The same problem appears on "Dell Latitude C810". So that should probably be
> > added to the dmi-backlist too. 
> 
> You have confirmed that allowing the local APIC to be enabled
> causes it to lock up at system management events, and that keeping
> the local APIC disabled prevents those lockups?
> 
> Send me the DMI scan output (change the dmi_printk #define in dmi_scan.c
> to actually do a printk) and I'll add the C810 to the blacklist.

I havn't tested your patch, but with CONFIG_X86_UP_APIC=y it locks up and
without it it doesn't. It isn't my laptop so can't do any futher
investigations at the moment, but the owner was very happy that he now could
plug the power without the computer locking up so probably he'll let me do
some more tests on it tomorrow.

-- 

//anders/g

