Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270050AbRHUArt>; Mon, 20 Aug 2001 20:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270087AbRHUArk>; Mon, 20 Aug 2001 20:47:40 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:2828 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S270050AbRHUArU>; Mon, 20 Aug 2001 20:47:20 -0400
Date: Mon, 20 Aug 2001 21:47:29 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alexandre Hautequest <hquest@fesppr.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IPX in 2.4.[5-9]
Message-ID: <20010820214729.F14353@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alexandre Hautequest <hquest@fesppr.br>, linux-kernel@vger.kernel.org
In-Reply-To: <998343425.3b818301718cd@webmail.fesppr.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <998343425.3b818301718cd@webmail.fesppr.br>; from hquest@fesppr.br on Mon, Aug 20, 2001 at 06:37:05PM -0300
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 20, 2001 at 06:37:05PM -0300, Alexandre Hautequest escreveu:

> What's the actual IPX support in linux? Is it broken since 2.4.7? Or i

no, it had bugs before for SMP configs and even for UP in some cases 8)

> just need to recompile my tools against a new kernel version -- the old
> ones was compiled in a 2.4.5 -- with any patch, option, whatever?

nothing as far as IPX is concerned
 
> hquest@condor:~$ dmesg
> (snip)
> IPX Portions Copyright (c) 1995 Caldera, Inc.
> IPX Portions Copyright (c) 2000, 2001 Conectiva, Inc.

you forgot the most important line, the version

> hquest@condor:~$ /sbin/ifconfig -v eth0    
> eth0      Link encap:Ethernet  HWaddr 00:00:F8:08:BD:A1  
>           inet addr:172.16.40.2  Bcast:172.16.255.255  Mask:255.255.0.0
>           IPX/Ethernet 802.2 addr:AC100000:0000F808BDA1
> (snip)
> hquest@condor:~$ slist
> slist: Server not found (0x8847) in ncp_open
> hquest@condor:~$ _
> 
> Not flaming anyone, just questioning.

I see ;) But Petr, that is the maintainer for ncpfs has already answered,
please do what he asks you to do, as the above message is mostly related
to ncpfs than to IPX.

If the problem persists and you think that is IPX related, please let me
know and I'll take a look, but I haven't received other reports related to
what you describe here.
 
- Arnaldo
