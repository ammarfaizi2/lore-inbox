Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312279AbSEVL4g>; Wed, 22 May 2002 07:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312296AbSEVL4f>; Wed, 22 May 2002 07:56:35 -0400
Received: from chaos.analogic.com ([204.178.40.224]:64128 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S312279AbSEVL4e>; Wed, 22 May 2002 07:56:34 -0400
Date: Wed, 22 May 2002 07:58:04 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Russell King <rmk@arm.linux.org.uk>, "David S. Miller" <davem@redhat.com>,
        paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.17 /dev/ports
In-Reply-To: <3CEB758B.2080304@evision-ventures.com>
Message-ID: <Pine.LNX.3.95.1020522075728.3222A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2002, Martin Dalecki wrote:

> Uz.ytkownik Russell King napisa?:
> > On Wed, May 22, 2002 at 12:13:05PM +0200, Martin Dalecki wrote:
> > 
> >>And now I'm just eagerly awaiting the first clueless
> >>l^Huser lurking on this list, who will flame me as usuall...
> >>But that's no problem - I got already used to it :-).
> > 
> > 
> > I'm waiting on Phil Blundell to notice - I think /dev/port may get used
> > on ARM to emulate inb() and outb() from userspace; I don't look after
> > glibc so shrug.
> > 
> > I agree however that /dev/port is a rotten interface that needs to go.
> > 
> 
> Hmm still not flames? Do they all sleep right now?
> 
> - Should I perhaps tell what I think about the glibc bloat^W coding style?
> 
> - Should I perhaps tell how "usefull" the GNU extensions to the POSIX
>    standards in question are?
> 
> - Or a side note about RH's slang and popt and other useless "required"
>    shared libraries?
> 
> - Is there maybe some Python module using /dev/port for precisely
>    the purpose you mention. (This is actually a good candidate.)
> 
> Anyway, dear Russell (plese note the double ll!):
> 
> [root@kozaczek glibc-2.2.5]# find ./ -name "*.[ch]" -exec grep \/dev\/port 
> /dev/null {} \;
> [root@kozaczek glibc-2.2.5]#
> 
> [root@kozaczek glibc-2.2.5]# find ./ -name "*.[ch]" -exec grep \"port\" 
> /dev/null {} \;
> ./hesiod/nss_hesiod/hesiod-service.c:  return lookup (portstr, "port", protocol, 
> serv, buffer, buflen, errnop);
> [root@kozaczek glibc-2.2.5]#
> [root@kozaczek glibc-2.2.5]# find ./ -name "*.[ch]" -exec grep outb\( /dev/null 
> {} \;
> [root@kozaczek glibc-2.2.5]#
> 
> So I rather think that glibc may be bloated but it's not idiotic and
> we have nothing to fear from it ;-)... well this time at least...
> As far as I know (and I know little about ARM). It would be anwyay
> unnatural to use /dev/port for the purpose you mention.
> ARM io space is memmory mapped, so if any file you would
> rather use /dev/kmem...
> 
> Still no flames? This silence makes me suspicious....
> 

Yawn...


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

