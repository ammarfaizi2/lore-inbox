Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312299AbSCTXuv>; Wed, 20 Mar 2002 18:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312300AbSCTXug>; Wed, 20 Mar 2002 18:50:36 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:38662 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S312297AbSCTXuE>; Wed, 20 Mar 2002 18:50:04 -0500
Date: Wed, 20 Mar 2002 19:44:27 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Gerd Knorr <kraxel@bytesex.org>
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre4: zr36067.c needs update?
In-Reply-To: <E16nq2a-0003l4-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0203201944010.9234-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Geert, 

Is the new API really backwards compatible ? ;)

On Thu, 21 Mar 2002, Alan Cox wrote:

> > /data2/usr/local/src/linux-2.4-pre/include/linux/modversions.h 
> > -DKBUILD_BASENAME=zr36067  -c -o zr36067.o zr36067.c
> > zr36067.c: In function `zoran_open':
> > zr36067.c:3268: structure has no member named `busy'
> > zr36067.c: At top level:
> 
> Revert the video4linux changes - I played with them briefly and found
> the same problem - they break most of the drivers.
> 

