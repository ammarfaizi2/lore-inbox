Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131200AbRBQUMc>; Sat, 17 Feb 2001 15:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131091AbRBQUMW>; Sat, 17 Feb 2001 15:12:22 -0500
Received: from filesrv1.baby-dragons.com ([199.33.245.55]:5901 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S131797AbRBQUMN>; Sat, 17 Feb 2001 15:12:13 -0500
Date: Sat, 17 Feb 2001 12:12:01 -0800 (PST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: <jbinpg@home.com>
cc: <stefan@hanse.com>, <linux-kernel@vger.kernel.org>
Subject: Re: re. too long mac address for --mac-source netfilter option
In-Reply-To: <20010217194308.GKTJ585.mail2.rdc2.bc.home.com@nonesuch.localdomain>
Message-ID: <Pine.LNX.4.32.0102171208230.20085-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello All,

On Sat, 17 Feb 2001 jbinpg@home.com wrote:
> Stefan Hanse writes -
> >Umm..  An ethernet MAC address is 48bit long, ie AA:BB:CC:DD:EE:FF, 6
>groups, not 14. Is this really an ethernet
> >interface? (If it really has 14 groups).
>
>> Good question. I have determined by scanning my firewall logs that the
>"invalid" mac addresses are all coming from cable modem routers. And my
>linux kernel is recognizing them as being MAC addresses. Would it be
>better to write another module looking for these long "MAC"  rather than
>tamper with the mac module?
>
>> To illustrate, here is a cut from my system log showing a portscan from
>my cable modem provider (a routine part of their service contract since
>you are not allowed to run client-side servers). SRC and DST have been
>x'ed out:
>
>> Feb 17 08:49:42 nonesuch kernel: IN=eth0 OUT=
>MAC=00:01:02:69:49:4f:00:00:77:93:83:d2:08:00 SRC=xx.xx.xx.xx
     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	This appears to be an ATM NSAP address .  Hth ,  JimL

>DST=xx.xx.xx.xx LEN=44 TOS=0x00 PREC=0x00 TTL=246 ID=21419 PROTO=TCP
>SPT=45435 DPT=119 WINDOW=8760 RES=0x00 SYN URGP=0
>> All hits on my firewall from cable modem servers other than my own
>provider also have the 14 group "MAC" address so it looks like this may
>be a feature of these units.

       +----------------------------------------------------------------+
       | James   W.   Laferriere | System  Techniques | Give me VMS     |
       | Network        Engineer | 25416      22nd So |  Give me Linux  |
       | babydr@baby-dragons.com | DesMoines WA 98198 |   only  on  AXP |
       +----------------------------------------------------------------+

