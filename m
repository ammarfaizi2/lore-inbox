Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261644AbTCZLlo>; Wed, 26 Mar 2003 06:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261646AbTCZLlo>; Wed, 26 Mar 2003 06:41:44 -0500
Received: from hera.cwi.nl ([192.16.191.8]:20968 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S261644AbTCZLln>;
	Wed, 26 Mar 2003 06:41:43 -0500
From: Andries.Brouwer@cwi.nl
Date: Wed, 26 Mar 2003 12:52:52 +0100 (MET)
Message-Id: <UTC200303261152.h2QBqqt09848.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, geert@linux-m68k.org
Subject: Re: Linux 2.5.66
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Geert Uytterhoeven <geert@linux-m68k.org>

    > -static void
    > +void

    Doesn't it make sense to move parse_bsd() to a separate file?
    Else we have to add a dependency on MSDOS_PARTITION to NEC98_PARTITION.

Yes, it does. But this PC-9800 stuff is still in flux.
Once it has settled down we can see whether reorganization
improves things. This is just the minimal compilation fix.

Andries
