Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316441AbSEOUZP>; Wed, 15 May 2002 16:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316446AbSEOUZO>; Wed, 15 May 2002 16:25:14 -0400
Received: from mail5.svr.pol.co.uk ([195.92.193.20]:28992 "EHLO
	mail5.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S316441AbSEOUZN>; Wed, 15 May 2002 16:25:13 -0400
Date: Wed, 15 May 2002 21:25:26 +0100
From: Stig Brautaset <stig@brautaset.org>
To: linux-kernel@vger.kernel.org
Subject: Re: xircom nic itch (drops ip)
Message-ID: <20020515202526.GA16671@brautaset.org>
In-Reply-To: <20020512214217.GA19727@brautaset.org> <200205131524.g4DFOAc30622@buggy.badula.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-URL: http://www.brautaset.org
X-Location: London, UK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ion,

Thanks for the answer :)

* Ion Badulescu <ionut@cs.columbia.edu> spake thus:
> > My pcmcia network card drops its ip from time to time. This happens
[...]
> Are you using dhcp on that interface? If so, what happens to the dhcp 
> client daemon when the interface 'loses' the ip? Is it logging anything?
> Is it dying?
> 
> If you're not using dhcp, I'm a little stumped..

I am using dhcp from time to time, but the card drops its ip when it is
allocated statically as well :(

However, it *does* seem to drop its ip more frequently if I am using
dhcp, or between usage of  dhcp and a reboot (I normally just use
suspend) so this might be the case. I will monitor this a bit closer...

> > The card is a Xircom Cardbus 10/100 NIC (CBEM56G-100), and it use the
> > kernel's xircom_cb module. I used to use the module in the pcmcia_cs
> > package before, but I can't remember whether it was any better then (I
> > don't think it was though).
> 
> You could try to use the xircom_tulip_cb module instead, and see if it
> solves the problem. I don't think it will, but who knows.

Can't seem to load that module I'm afraid.. 

> Despite what Configure.help says, xircom_tulip_cb is actually better
> than xircom_cb. The latter should only be used if xircom_tulip_cb
> has problems -- I haven't heard of any recently, but I do want to hear
> about them if they still exist.

Thank you very much for your help anyway.

Stig
-- 
brautaset.org
