Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316650AbSE0PKO>; Mon, 27 May 2002 11:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316655AbSE0PKN>; Mon, 27 May 2002 11:10:13 -0400
Received: from pD952A637.dip.t-dialin.net ([217.82.166.55]:65445 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316650AbSE0PKM>; Mon, 27 May 2002 11:10:12 -0400
Date: Mon, 27 May 2002 09:08:43 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: "J.A. Magallon" <jamagallon@able.es>
cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH][RFC] gcc3 arch options
In-Reply-To: <20020527150048.GC6738@werewolf.able.es>
Message-ID: <Pine.LNX.4.44.0205270906450.15928-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 ifdef CONFIG_M686
 CFLAGS += -march=i686
-CFLAGS += $(shell if $(CC) -march=pentium-pro -S -o /dev/null -xc > /dev/null >/dev/null 2>&1; then echo "-march=pentium-pro; else echo > "-march=i686"; fi)
+CFLAGS += $(shell if $(CC) -march=pentium-pro -S -o /dev/null -xc > /dev/null >/dev/null 2>&1; then echo "-march=pentium-pro"; else echo > "-march=i686"; fi)
 endif

Regards,
Thunder
-- 
Was it a black who passed along in the sand?
Was it a white who left his footprints?
Was it an african? An indian?
Sand says, 'twas human.

