Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262777AbSJCL60>; Thu, 3 Oct 2002 07:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263216AbSJCL60>; Thu, 3 Oct 2002 07:58:26 -0400
Received: from sproxy.gmx.net ([213.165.64.20]:8079 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S262777AbSJCL6Z>;
	Thu, 3 Oct 2002 07:58:25 -0400
Date: Fri, 4 Oct 2002 14:01:44 +0200
From: Dexter Filmore <Dexter.Filmore@gmx.de>
To: kernel <linux-kernel@vger.kernel.org>
Subject: IDE subsystem issues with 2.4.18/19
Message-Id: <20021004140144.418a8569.Dexter.Filmore@gmx.de>
Organization: SCHWA Corporation
X-Mailer: Sylpheed version 0.8.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got a motherboard with VIA VT8233 Southbridge (a MSI K7T266 Pro2), Slackware
8.1 with a standard kernel (tried .18 as well as .19) patched with SGI XFS
support, two atapi drives attached with /dev/hdc is Pioneer115 DVD and
/dev/hdd is a Traxdata 24x-writer, both running in scsi emulation.
Got VIA-support compiled in.

Everythings runs fine: reading DVD, reading CD, writing CD. 
*Apart from*: CD ripping. When trying to read audio CDs, the system locks up,
can't reproduce the exact error msgs right now, need a running system atm. If
you like, I'll post them later on.

Tried cdparanoia 9.8-III, cdda2wav - nothing works.

I contacted Vojtech Pavlik, the author of the via82xxx.c code who advised me
to ask Alan Cox or Andre Hedrick about this, so I thought best write to this
list.
Are there any workarounds/patches/voodoo magic for this problem?

Dex


-- 
-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCS d--(+)@ s-:+ a-- C++(+++) UL>+++ P+>++ L++>++++ E-- W++ N+
o? K- w--(---) !O M-- V- PS+ PE(+) Y+>++ PGP- t+(++)
5 X+(++) R++ tv--(+)@ b++(+++) DI+++ D G++(--) e* h r%>* y?
------END GEEK CODE BLOCK------

Nothing fights like the opposition
