Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315792AbSFCX1U>; Mon, 3 Jun 2002 19:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315794AbSFCX1T>; Mon, 3 Jun 2002 19:27:19 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:35078 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S315792AbSFCX1S>; Mon, 3 Jun 2002 19:27:18 -0400
Date: Mon, 3 Jun 2002 20:27:08 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, Pawel Kot <pkot@linuxnews.pl>,
        lkml <linux-kernel@vger.kernel.org>,
        Andre Hedrick <andre@serialata.org>
Subject: Re: Another -pre
Message-ID: <20020603232707.GI6062@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Pawel Kot <pkot@linuxnews.pl>, lkml <linux-kernel@vger.kernel.org>,
	Andre Hedrick <andre@serialata.org>
In-Reply-To: <Pine.LNX.4.44.0206031155200.4146-100000@freak.distro.conectiva> <1023149710.6773.82.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 04, 2002 at 01:15:10AM +0100, Alan Cox escreveu:
> With the current code I've got these items on my list I class as
> problematic.

you mean with 2.4.19-pre9 or with 2.4.19-pre9-ac3?
 
> 1 Weird corruption report with AMD chipset in PIO mode

Oh, I'm not alone ;) Well, up to now it _seems_ that ext3 is saving my day,
but it only happened two time after I upgraded to 2.4.19-pre8-ac5, none after
I upgraded to 2.4.19-pre9-ac3, but I can't manage to make 'hdparm -X68 /dev/hdd'
to work :( I have already sent detailed information to Andre and discussed
and tried several things sugested in a irc chat.

Short description: I use ext3 over raid0, using /dev/hda4 and /dev/hdd1,
/dev/hdc has a CDRW drive, mostly unused, /dev/hdb has nothing, two times
/dev/hda stopped responding, not reproducible AFAIT.

- Arnaldo
