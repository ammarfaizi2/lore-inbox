Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273213AbRJaVmG>; Wed, 31 Oct 2001 16:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273305AbRJaVl4>; Wed, 31 Oct 2001 16:41:56 -0500
Received: from h55p103-2.delphi.afb.lu.se ([130.235.187.175]:9686 "EHLO gin")
	by vger.kernel.org with ESMTP id <S273213AbRJaVlp>;
	Wed, 31 Oct 2001 16:41:45 -0500
Date: Wed, 31 Oct 2001 22:42:01 +0100
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Local APIC option (CONFIG_X86_UP_APIC) locks up Inspiron 8100
Message-ID: <20011031224201.B6285@h55p111.delphi.afb.lu.se>
In-Reply-To: <200110312011.VAA28277@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200110312011.VAA28277@harpo.it.uu.se>
User-Agent: Mutt/1.3.23i
From: andersg@0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Oct 31, 2001 at 09:11:38PM +0100, Mikael Pettersson wrote:
> I wrote:
> > > Not all BIOS firmware can cope when we switch to UP-APIC. Some laptops 
> > > really don't like it one bit.
> >
> >Correct, and the I8x00 is the prime example of that.
> >
> >I have a fix, but it involves fairly major surgery:
> >- Implement bt_ioremap()/bt_iounmap() which work at early boot-time (the
> >  normal ioremap doesn't work yet).
> >...
> >The patch is still _very_ rough, but it seems to work. Let me know if you want it.
> 
> The patch is now available at
> http://www.csd.uu.se/~mikpe/linux/patch-2.4.13ac5-init-order-5

The same problem appears on "Dell Latitude C810". So that should probably be
added to the dmi-backlist too. 

-- 

//anders/g

