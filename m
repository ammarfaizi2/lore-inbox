Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316662AbSE0PdR>; Mon, 27 May 2002 11:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316661AbSE0PdQ>; Mon, 27 May 2002 11:33:16 -0400
Received: from pD952A637.dip.t-dialin.net ([217.82.166.55]:39850 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316660AbSE0PdQ>; Mon, 27 May 2002 11:33:16 -0400
Date: Mon, 27 May 2002 09:33:15 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] gcc3 arch options
Message-ID: <Pine.LNX.4.44.0205270932340.15928-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 27 May 2002, David Woodhouse wrote:
> jamagallon@able.es said:
> > +CFLAGS += $(shell if $(CC) -march=pentium-mmx -S -o /dev/null -xc /
> > dev/null >/dev/null 2>&1; then echo "-march=pentium-mmx"; else echo
> > "-march=i586"; fi)
> 
> Doesn't this run the shell command every time $(CFLAGS) is used?

It does. But I don'y know whether it is _TOO_ expensive, others do it as 
well. I think in the GCC compile we have it either.

However, we might better determine that in advance.

Regards,
Thunder
-- 
Was it a black who passed along in the sand?
Was it a white who left his footprints?
Was it an african? An indian?
Sand says, 'twas human.


