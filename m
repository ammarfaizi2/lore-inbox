Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316161AbSFPLQ0>; Sun, 16 Jun 2002 07:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316163AbSFPLQZ>; Sun, 16 Jun 2002 07:16:25 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:1517 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S316161AbSFPLQZ>; Sun, 16 Jun 2002 07:16:25 -0400
Date: Sun, 16 Jun 2002 13:16:21 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Rolf Fokkens <fokkensr@linux06.vertis.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] [2.4.19-pre10] pcilynx doesn't compile
In-Reply-To: <200206152143.g5FLhEJ25954@linux06.vertis.nl>
Message-ID: <Pine.NEB.4.44.0206161314360.11043-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jun 2002, Rolf Fokkens wrote:

> Hi!

Hi Rolf!

> While trying to compile 2.4.19 the following error occurs:
>
> pcilynx.c: In function `mem_open':
> pcilynx.c:647: `num_of_cards' undeclared (first use in this function)
> pcilynx.c:647: (Each undeclared identifier is reported only once
> pcilynx.c:647: for each function it appears in.)
> pcilynx.c:647: `cards' undeclared (first use in this function)
> pcilynx.c: In function `aux_poll':
> pcilynx.c:706: `cards' undeclared (first use in this function)
>
> Relevant config options seem to me:
>
>...
> CONFIG_IEEE1394_PCILYNX_PORTS=y

Thanks for the report. This is a known issue. The option is already
disabled in Marcelo's BitKeeper repository and it will therefore no longer
be present in -pre11 (or -rc1).

> Cheers,
>
> Rolf

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

