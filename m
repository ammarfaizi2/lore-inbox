Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263491AbSLJRrq>; Tue, 10 Dec 2002 12:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263544AbSLJRrq>; Tue, 10 Dec 2002 12:47:46 -0500
Received: from mallard.mail.pas.earthlink.net ([207.217.120.48]:4510 "EHLO
	mallard.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S263491AbSLJRrp>; Tue, 10 Dec 2002 12:47:45 -0500
Date: Tue, 10 Dec 2002 10:48:19 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Jochen Hein <jochen@delphi.lan-ks.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.51, FB] missing EXPORT_SYMBOL(fb_blank) in fbmem.c
In-Reply-To: <E18Lmj7-00011o-00@gswi1164.jochen.org>
Message-ID: <Pine.LNX.4.33.0212101047320.2617-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I compiled fbcon and neofb as modules, when loading fbcon I get:
>
> root@gswi1164:~# modprobe fbcon
> fbcon: Unknown symbol fb_blank
> FATAL: Error inserting fbcon (/lib/modules/2.5.51/kernel/fbcon.ko): Unknown symbol in module

Oops. One of those last minute changes which I didn't test with a modular
setup. Will fix right away.

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@users.sf.net] 	                ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

