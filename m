Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316195AbSFEUAd>; Wed, 5 Jun 2002 16:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316204AbSFEUAc>; Wed, 5 Jun 2002 16:00:32 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:30444 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S316195AbSFEUAa>; Wed, 5 Jun 2002 16:00:30 -0400
Date: Wed, 5 Jun 2002 22:00:24 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Henrique Gobbi <henrique@cyclades.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Conflicting symbols of zlib (jffs2 and ppp_deflate)
In-Reply-To: <02060512070101.28263@henrique.cyclades.com.br>
Message-ID: <Pine.NEB.4.44.0206052158050.11522-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jun 2002, Henrique Gobbi wrote:

> Hello !!!

Hi Henrique,

> I've found out something that probably is a bug. I've tried to compile a
> kernel using the generic ppp (and the ppp_deflate module) and the jffs2 file
> system.
>...
> I'd like to know if anyone (ppp and jffs2 guys) have a solution for this
> problem or at least a suggestion. Any comment will be very welcomed.

this is a well-known issue. David Woodhouse developed a patch that is in
the -ac kernels since 2.4.19pre2-ac4 to fix this issue.

> thanks
> henrique

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


