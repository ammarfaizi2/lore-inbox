Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312294AbSCTXrv>; Wed, 20 Mar 2002 18:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312297AbSCTXrl>; Wed, 20 Mar 2002 18:47:41 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:42001 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312294AbSCTXr3>; Wed, 20 Mar 2002 18:47:29 -0500
Subject: Re: Linux 2.4.19-pre4: zr36067.c needs update?
To: eyal@eyal.emu.id.au (Eyal Lebedinsky)
Date: Thu, 21 Mar 2002 00:02:48 +0000 (GMT)
Cc: marcelo@conectiva.com.br (Marcelo Tosatti),
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <3C991CD7.304631FC@eyal.emu.id.au> from "Eyal Lebedinsky" at Mar 21, 2002 10:35:51 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16nq2a-0003l4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> /data2/usr/local/src/linux-2.4-pre/include/linux/modversions.h 
> -DKBUILD_BASENAME=zr36067  -c -o zr36067.o zr36067.c
> zr36067.c: In function `zoran_open':
> zr36067.c:3268: structure has no member named `busy'
> zr36067.c: At top level:

Revert the video4linux changes - I played with them briefly and found
the same problem - they break most of the drivers.
