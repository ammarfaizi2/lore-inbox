Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262238AbTCWDLS>; Sat, 22 Mar 2003 22:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262239AbTCWDLS>; Sat, 22 Mar 2003 22:11:18 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61710 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262238AbTCWDLS>; Sat, 22 Mar 2003 22:11:18 -0500
Date: Sat, 22 Mar 2003 19:21:11 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parallel port
In-Reply-To: <200303230000.h2N00nZX020752@hraefn.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0303221919160.2959-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This one causes 

	drivers/parport/parport_pc.c:2273: warning: implicit declaration of function `rename_region'
	drivers/built-in.o(.text+0x77a8c): In function `parport_pc_probe_port':
	: undefined reference to `rename_region'

for me. I think I complained about that once before already. Tssk, tssk.

		Linus

