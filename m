Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316673AbSHGWGx>; Wed, 7 Aug 2002 18:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316795AbSHGWGx>; Wed, 7 Aug 2002 18:06:53 -0400
Received: from axp01.e18.physik.tu-muenchen.de ([129.187.154.129]:17927 "EHLO
	axp01.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S316673AbSHGWGv>; Wed, 7 Aug 2002 18:06:51 -0400
Date: Thu, 8 Aug 2002 00:10:31 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: kwijibo@zianet.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at tg3.c:1557
In-Reply-To: <3D51940A.60805@zianet.com>
Message-ID: <Pine.LNX.4.44.0208080007300.4058-100000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2002 kwijibo@zianet.com wrote:

> Ok, I just tried it with a 3GB file transfer, still
> held up.  Only thing I see different from what you have is
> I have it running on the Thunder 2468, I have one more 7850,
> and its just stock 2.4.19.  I think the big factor would be the 2466
> vs the 2468 however.  I believe they both have the same chipset.
> 
Since the insertion of a dummy write solved the problem, I would say it's 
the chipset's PCI reordering, which is malfunctioning in the 2466. I don't 
know the difference in BIOS version etc. between 2466 and 2468.

Ciao,
					Roland

+---------------------------+-------------------------+
|    TU Muenchen            |                         |
|    Physik-Department E18  |  Raum    3558           |
|    James-Franck-Str.      |  Telefon 089/289-12592  |
|    85747 Garching         |                         |
+---------------------------+-------------------------+

