Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264900AbUD2Q62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264900AbUD2Q62 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 12:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264894AbUD2Q61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 12:58:27 -0400
Received: from pa208.myslowice.sdi.tpnet.pl ([213.76.228.208]:23199 "EHLO
	finwe.eu.org") by vger.kernel.org with ESMTP id S264900AbUD2Q6S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 12:58:18 -0400
Date: Thu, 29 Apr 2004 19:01:12 +0200
From: Jacek Kawa <jfk@zeus.polsl.gliwice.pl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.6-rc3
Message-ID: <20040429170111.GA24184@finwe.eu.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0404271858290.10799@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0404271858290.10799@ppc970.osdl.org>
Organization: Kreatorzy Kreacji Bialej
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm hoping to do a final 2.6.6 later this week, so I'm hoping as many 
> people as possible will test this.

Just made oldconfig after 2.6.6-rc1:

CC      drivers/char/vt_ioctl.o
CC      drivers/char/vc_screen.o
CC      drivers/char/consolemap.o
CONMK   drivers/char/consolemap_deftbl.c
CC      drivers/char/consolemap_deftbl.o
CC      drivers/char/selection.o
CC      drivers/char/keyboard.o
CC      drivers/char/vt.o
SHIPPED drivers/char/defkeymap.c
CC      drivers/char/defkeymap.o
CC      drivers/char/sysrq.o
LD      drivers/char/agp/built-in.o
CC [M]  drivers/char/agp/backend.o
CC [M]  drivers/char/agp/frontend.o
CC [M]  drivers/char/agp/generic.o
make[3]: *** No rule to make target `drivers/char/agp/isoch.s', needed
by `drivers/char/agp/isoch.o'.
make[2]: *** [drivers/char/agp] Error 2
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2

mrproper cannot clean it this time...

config: http://zeus.polsl.gliwice.pl/~jfk/kernel/config-2.6.6-rc3

bye

-- 
Jacek Kawa
