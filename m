Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319316AbSHGTtv>; Wed, 7 Aug 2002 15:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319317AbSHGTtu>; Wed, 7 Aug 2002 15:49:50 -0400
Received: from axp01.e18.physik.tu-muenchen.de ([129.187.154.129]:48390 "EHLO
	axp01.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S319316AbSHGTts>; Wed, 7 Aug 2002 15:49:48 -0400
Date: Wed, 7 Aug 2002 21:53:27 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: kwijibo@zianet.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at tg3.c:1557
In-Reply-To: <3D517A78.704@zianet.com>
Message-ID: <Pine.LNX.4.44.0208072149190.3705-100000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2002 kwijibo@zianet.com wrote:

> I just tried this on a dual Athlon box with two 7850's in it
> and a 3C996B-T as well.  Lucky for me though, this
> error did not show up.  I transfered/received two 800MB files
> to the RAID and it held up ok.  What driver version are you
> using? Or even kernel version.
> 
Tyan Tiger (2466) v1.02
3ware 7850 (software revision 7.5)
3C996B-T (runs with 33Mhz, don't know why)
2*Athlon MP 1900+
kernel 2.4.19 vanilla

The script to reproduce this copies simultanously from the disk to the 
network and back. Be sure to really hit the disk: 800MB did not show the 
error in my case, if all was in RAM.

Ciao,
					Roland

+---------------------------+-------------------------+
|    TU Muenchen            |                         |
|    Physik-Department E18  |  Raum    3558           |
|    James-Franck-Str.      |  Telefon 089/289-12592  |
|    85747 Garching         |                         |
+---------------------------+-------------------------+

