Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262003AbREQQVl>; Thu, 17 May 2001 12:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262000AbREQQVb>; Thu, 17 May 2001 12:21:31 -0400
Received: from [164.77.245.130] ([164.77.245.130]:2053 "HELO
	dec1.hc1.vtrnet.cl") by vger.kernel.org with SMTP
	id <S262003AbREQQVR>; Thu, 17 May 2001 12:21:17 -0400
Date: Thu, 17 May 2001 12:20:19 -0400 (CLT)
From: Fabian Arias <dewback@vtr.net>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: Rik van Riel <riel@conectiva.com.br>, virii <virii@gcecisp.com>,
        linux-kernel@vger.kernel.org
Subject: Re: cmpci sound chip lockup
In-Reply-To: <20010517135808.G754@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.LNX.4.21.0105171210310.1166-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I can also report that I'm having the same problem running kernel
2.4.[3-4{ac1-9}] with a C-Media using ESD. So the problem appears when I
tried to run XMMS with ESD, the sound have an annoying "ss ss ss
..." while I play mp3's. The frecuency of the "ss ss ss ..." is symetrical
(1/4 of a second I say).
The problem appears to have a direct asociation with esound cause it only
happens with the use of XMMS over ESD. No problems reported during
execution of mpg123 wich not use esound.

ronto:~# lspci
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 630 Host (rev 21)
00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev
d0)
00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
00:01.1 Ethernet controller: Silicon Integrated Systems [SiS] SiS900
10/100 Ethernet (rev 83)
00:01.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
00:01.3 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
00:02.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP
00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev
10)
01:00.0 VGA compatible controller: Silicon Integrated Systems
[SiS]: Unknown device 6300 (rev 21)


On Thu, 17 May 2001, Ingo Oeser wrote:

> Date: Thu, 17 May 2001 13:58:08 +0200
> From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
> To: Rik van Riel <riel@conectiva.com.br>
> Cc: virii <virii@gcecisp.com>, linux-kernel@vger.kernel.org
> Subject: Re: cmpci sound chip lockup
> 
> On Wed, May 16, 2001 at 08:02:06PM -0300, Rik van Riel wrote:
> > I'm seeing a similar thing on 2.4.4-pre[23], but in a far less
> > serious way. Using xmms the music stops after anything between
> > a few seconds and a minute, I suspect a race condition somewhere.
> > 
> > Using mpg123 everything works fine...
> 
> Your xmms uses esd[1]?
> 
> Friends of mine report problems with esd and 2.4.x. Tested on
> SB-Live! and es1371.
> 
> Regards
> 
> Ingo Oeser
> 
> [1] E Sound Deamon - A sound mixing framework
> -- 
> To the systems programmer,
> users and applications serve only to provide a test load.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Fabian Arias Mu~oz                     |        Debian GNU/Linux 2.2r3 Potato
 Facultad de Cs. Economicas y           |            Corriendo en Kernel 2.4.4
 Administrativas.                       |                           dewback en
 Universidad de Concepcion   -  Chile   |                 #linuxhelp IRC.CHILE

