Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131850AbRBQWMT>; Sat, 17 Feb 2001 17:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131984AbRBQWMJ>; Sat, 17 Feb 2001 17:12:09 -0500
Received: from mail2.rdc2.bc.home.com ([24.2.10.85]:8907 "EHLO
	mail2.rdc2.bc.home.com") by vger.kernel.org with ESMTP
	id <S131850AbRBQWL4>; Sat, 17 Feb 2001 17:11:56 -0500
To: linux-kernel@vger.kernel.org
From: jpinpg@home.com
Subject: Re: re. too long mac address for --mac-source netfilter option
X-Mailer: Gmail 0.6.8 (http://gmail.linuxpower.org)
Message-Id: <20010217221149.HDKR585.mail2.rdc2.bc.home.com@nonesuch.localdomain>
Date: Sat, 17 Feb 2001 14:11:49 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


James L. wrote -
> Hello All,
> 
> On Sat, 17 Feb 2001 jbinpg@home.com wrote:
> > Stefan Hanse writes -
> > >Umm..  An ethernet MAC address is 48bit long, ie AA:BB:CC:DD:EE:FF, 6
> >groups, not 14. Is this really an ethernet
> > >interface? (If it really has 14 groups).
> >
> >> Good question. I have determined by scanning my firewall logs that the
> >"invalid" mac addresses are all coming from cable modem routers. And my
> >linux kernel is recognizing them as being MAC addresses. Would it be
> >better to write another module looking for these long "MAC"  rather than
> >tamper with the mac module?
> >
> >> To illustrate, here is a cut from my system log showing a portscan from
> >my cable modem provider (a routine part of their service contract since
> >you are not allowed to run client-side servers). SRC and DST have been
> >x'ed out:
> >
> >> Feb 17 08:49:42 nonesuch kernel: IN=eth0 OUT=
> >MAC=00:01:02:69:49:4f:00:00:77:93:83:d2:08:00 SRC=xx.xx.xx.xx
>      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 	This appears to be an ATM NSAP address .  Hth ,  JimL

OK, thanks Jim. The question then becomes: could a netfilter module for recognizing ATM addresses be developed? Are all ATM addresses 14 groups?

Jack Bowling
mailto: jbinpg@home.com
