Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131408AbRDFJ7E>; Fri, 6 Apr 2001 05:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131424AbRDFJ6x>; Fri, 6 Apr 2001 05:58:53 -0400
Received: from sky.irisa.fr ([131.254.60.147]:21456 "EHLO sky.irisa.fr")
	by vger.kernel.org with ESMTP id <S131408AbRDFJ6g>;
	Fri, 6 Apr 2001 05:58:36 -0400
Message-ID: <3ACD9322.91FDFB2A@irisa.fr>
Date: Fri, 06 Apr 2001 11:57:54 +0200
From: Romain Dolbeau <dolbeau@irisa.fr>
Organization: IRISA, Campus de Beaulieu, 35042 Rennes Cedex, FRANCE
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-fbdev-devel@lists.sourceforge.net
Subject: [DRIVER] New framebuffer driver for Permedia3 (2.2.x & 2.4.y)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[To:linux-kernel & CC:linux-fbdev-devel]

Hello,

I've written a framebuffer (fbdev) driver for the 3DLabs Permedia3
chipset, targeted at both kernel 2.2.x and 2.4.y, and available at:

<http://www.irisa.fr/prive/dolbeau/pm3fb/pm3fb.html>

As mentioned on the page, the driver hasn't been thoroughly
tested except on my board, as even after two announcements
on the fbdev-devel list there hasn't been any answer beside
a XFree86 driver develloper. Fortunately that's two different
boards on two different architectures of different endianess.

The only _known_ remaining bug relate to depth switching,
going from 8 to 16/32 bpp give a wrong colormap (need to
go to X and back to restore). The only known current fix
is a small patch again driver/video/fbgen.c that probably
break something else, so I haven't included it in the
distributed patch.

If the driver is ever integrated, here's the MAINTAINERS
stuff: (not yet included in the linux kernel patches)

PERMEDIA 3 FRAMEBUFFER DRIVER
P: Romain Dolbeau
M: dolbeau@irisa.fr
L: linux-fbdev-devel@lists.sourceforge.net
W: <http://www.irisa.fr/prive/dolbeau/pm3fb/pm3fb.html>
S: Maintained

Hope someone will find it useful,

-- 
DOLBEAU Romain               | l'histoire est entierement vraie, puisque
ENS Cachan / Ker Lann        |     je l'ai imaginee d'un bout a l'autre
dolbeau@irisa.fr             |           -- Boris Vian
