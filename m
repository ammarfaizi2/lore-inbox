Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317334AbSHBXwj>; Fri, 2 Aug 2002 19:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317349AbSHBXwj>; Fri, 2 Aug 2002 19:52:39 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:13577 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S317334AbSHBXwW>; Fri, 2 Aug 2002 19:52:22 -0400
Date: Fri, 2 Aug 2002 20:05:10 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Nick Orlov <nick.orlov@mail.ru>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pdc20265 problem.
In-Reply-To: <Pine.SOL.4.30.0208022057130.9348-100000@mion.elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.44.0208022004150.3717-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 2 Aug 2002, Bartlomiej Zolnierkiewicz wrote:

>
> > Just FYI,
> >
> > before these "#ifdef" fixes it was treated as OFF_BOARD unless
> > CONFIG_PDC202XX_FORCE is set. (now it's inverted)
>
> This should be fixed.

If we change the #ifdef on ide-pci.c it will skip some controllers which
worked before _without_ CONFIG_PDC202XX_FORCE set.



