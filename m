Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292627AbSB0Wy5>; Wed, 27 Feb 2002 17:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293022AbSB0Wy1>; Wed, 27 Feb 2002 17:54:27 -0500
Received: from nobugconsulting.ro ([213.157.160.38]:44672 "EHLO
	mail.nobugconsulting.ro") by vger.kernel.org with ESMTP
	id <S293021AbSB0Ww3>; Wed, 27 Feb 2002 17:52:29 -0500
Message-ID: <3C7D632C.46CE687@pcnet.ro>
Date: Thu, 28 Feb 2002 00:52:28 +0200
From: lonely wolf <wolfy@pcnet.ro>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
Subject: Re: disk transfer speed problem
In-Reply-To: <Pine.LNX.4.33.0202271701360.13103-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn wrote:

> > initial data: one brand new intel bonham motherboard (i815) , 900 MHz
> > celeron processor
>
> what's the ram config?  that's probably one of the old/slow
> FSB66 celerons, but is the ram fast?

the processor has 100 MB FSB
The memory is PC133, 1 DIMM of 128 MB

> >  DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
>
> fine, udma100.

i know


> > The problem:
> > #/sbin/hdparm -tTf /dev/hdd
> >
> > /dev/hdd:
> >  Timing buffer-cache reads:   128 MB in  1.17 seconds =109.40 MB/sec
> >  Timing buffered disk reads:  64 MB in  3.24 seconds = 19.75 MB/sec
>
> well, 109 MB/s is pretty low for buffer-cache reads; this reflects
> the relative crippled-ness of your cpu/dram/chipset.

well... i would't name a Celeron 900 MHz crippled. PC133 is the best the
board gets... and now the speed is lower then the previous server which was
an Athlon 600 pluggede in an Asus VIA KX133 based mobo.

> doesn't the i815 have integrated video,

yes

> and if so, are you using it,

yes

> and if so, do you have the optional "display cache"?

couldn't find any BIOS setting for that. where should it be ?

> without the DC, video steals quite a lot of dram bandwidth...

the machine is (should be)  a NFS server, I couldn't care less about the
video

--
      Manuel Wolfshant       linux registered user #131416
       network administrator    NoBug Consulting Romania
             Beware the fury of a patient man.




