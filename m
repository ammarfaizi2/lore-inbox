Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbTJPKTK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 06:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262796AbTJPKTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 06:19:10 -0400
Received: from a205017.upc-a.chello.nl ([62.163.205.17]:4992 "EHLO
	mail.fluido.as") by vger.kernel.org with ESMTP id S262792AbTJPKTF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 06:19:05 -0400
Date: Thu, 16 Oct 2003 12:19:05 +0200
From: "Carlo E. Prelz" <fluido@fluido.as>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: FBDEV 2.6.0-test7 updates.
Message-ID: <20031016101905.GA7454@casa.fluido.as>
References: <20031015162056.018737f1.akpm@osdl.org> <Pine.LNX.4.44.0310160022210.13660-100000@phoenix.infradead.org> <20031016091918.GA1002@casa.fluido.as> <1066298431.1407.119.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1066298431.1407.119.camel@gaston>
X-operating-system: Linux casa 2.6.0-test7
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Subject: Re: [Linux-fbdev-devel] Re: FBDEV 2.6.0-test7 updates.
	Date: gio, ott 16, 2003 at 12:00:32 +0200

Quoting Benjamin Herrenschmidt (benh@kernel.crashing.org):

> My new driver (bk://ppc.bkbits.net/linuxppc-2.5-benh) now uses a copy
> of XFree PCI IDs list, making it much easier to keep in sync. It should
> also support the 9200.

The latest (*NON*bk) patch distributed by James appears to include your
new driver. The header from radeon_base.c  reads:

--8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<--

/*
 *      drivers/video/radeonfb.c
 *      framebuffer driver for ATI Radeon chipset video boards
 *
 *      Copyright 2003  Ben. Herrenschmidt <benh@kernel.crashing.org>
 *      Copyright 2000  Ani Joshi <ajoshi@kernel.crashing.org>
 *
 *      i2c bits from Luca Tettamanti <kronos@kronoz.cjb.net>
 *
 *      Special thanks to ATI DevRel team for their hardware donations.
 *
 *      ...Insert GPL boilerplate here...
 *
 *      TODO: - Bring a couple of cleanups from 2.4 to the mode setting code,
 *            - Split CRT vs. FP register calc/setting
 *            - Add CRTC2 support for mirror at least, dual head then
 *            - Add back some accel
 *
 */


#define RADEON_VERSION  "0.2.0"

--8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<--


Thus the rest of my previous message should be referred to
your new driver.

Carlo

PS I am BK-handicapped. I had downloaded the program, and tried your
instruction as per an old message of yours, and no download would take
place. Since, if I recall correctly, bk cannot be used for free on
closed-source projects, I cannot switch to it (nor lose too much time
on it): I work on projects of both types, and changing every time
between RCS/CVS and bk would be very umcomfortable.

-- 
  *         Se la Strada e la sua Virtu' non fossero state messe da parte,
* K * Carlo E. Prelz - fluido@fluido.as             che bisogno ci sarebbe
  *               di parlare tanto di amore e di rettitudine? (Chuang-Tzu)
