Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267769AbTAXQGp>; Fri, 24 Jan 2003 11:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267762AbTAXQGp>; Fri, 24 Jan 2003 11:06:45 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:43774 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S267769AbTAXQGo>; Fri, 24 Jan 2003 11:06:44 -0500
Message-Id: <200301241614.h0OGEmIE001360@eeyore.valparaiso.cl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4.21-pre3 (bk from 20020123) + ALi M5451 == hang
Date: Fri, 24 Jan 2003 17:14:48 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a Toshiba Satellite 1800, with said sound card, running RH 8.0 +
updates. When starting xmms the system (semi-)hangs: It seems to work for a
fraction of a second and stops for seconds at a time. No shift-lock, mouse,
nothing. Only way out was to turn it off (perhaps with more patience I
could've got in to reboot cleanly, but...). /var/logg/messages ends with:

Jan 24 17:06:29 eeyore kernel: ac97_codec: AC97  codec, id: 0x0000:0x0000 (Unknown)
Jan 24 17:06:29 eeyore kernel: ali_ac97_read :try clear busy flag
Jan 24 17:06:29 eeyore kernel: ali_ac97_set :try clear busy flag!!
Jan 24 17:06:29 eeyore kernel: ali_ac97_read :try clear busy flag
Jan 24 17:06:29 eeyore kernel: ali_ac97_set :try clear busy flag!!
Jan 24 17:06:29 eeyore last message repeated 10 times

The "try clear busy flag" repeats ad nauseam before too.

Obviously no sound at all.

Hadn't this been fixed in -ac?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
