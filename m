Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbTD3WJE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 18:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262474AbTD3WJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 18:09:04 -0400
Received: from air-2.osdl.org ([65.172.181.6]:60121 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262470AbTD3WJA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 18:09:00 -0400
Date: Wed, 30 Apr 2003 15:19:02 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: gj@pointblue.com.pl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.68-bk10 - usbkbd.c compilation error
Message-Id: <20030430151902.4ad4f5d8.rddunlap@osdl.org>
In-Reply-To: <200304302212.h3UMCDV00426@devserv.devel.redhat.com>
References: <mailman.1051727220.20780.linux-kernel2news@redhat.com>
	<200304302212.h3UMCDV00426@devserv.devel.redhat.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Apr 2003 18:12:13 -0400 Pete Zaitcev <zaitcev@redhat.com> wrote:

| >   gcc -Wp,-MD,drivers/usb/input/.usbkbd.o.d -D__KERNEL__ -Iinclude -Wall
| > -DKBUILD_MODNAME=usbkbd -c -o drivers/usb/input/.tmp_usbkbd.o
| > drivers/usb/input/usbkbd.c
| 
| Just curious, why do you use usbkbd and usbmouse?
| I think they should have been removed from the kernel long ago.

Those options are somewhat hidden in 2.5 *config.
Someone has to go out of their way to select them, and if that
happens, they should really want/need to use them.

There are better choices of (non-building) drivers that could be
removed IMO.

--
~Randy
