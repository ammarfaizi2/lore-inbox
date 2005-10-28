Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030233AbVJ1QaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbVJ1QaS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 12:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbVJ1QaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 12:30:17 -0400
Received: from electra.cc.umanitoba.ca ([130.179.16.23]:4299 "EHLO
	electra.cc.umanitoba.ca") by vger.kernel.org with ESMTP
	id S1030233AbVJ1QaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 12:30:16 -0400
Message-ID: <43625208.60703@cc.umanitoba.ca>
Date: Fri, 28 Oct 2005 11:30:00 -0500
From: Mark Jenkins <umjenki5@cc.umanitoba.ca>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Is sharpzdc_cs.o not a derivitive work of Linux?
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linux developers,

Sharp Electronics Corporation manufactures a series of handheld
computers called the Zaurus. The new ones run Linux.

Sharp sells a digital camera, the CE-AG06 that works with the SL-5500,
SL-5600 and SL-6000. To use this camera, a Linux module sharpzdc_cs.o is
required.

There are several copies of the Linux Zaurus source on the web; none of
them contain the source code for this module. I am attempting to use the
official source code offer that came with the device instead of the web
copies. When I do manage to get Sharp to do this, I anticipate they will
not include the source for this particular module.

Sharp distributes sharpzdc_cs.o in the Zaurus ROM image alongside Linux.

You can look at the module here:
http://oz.pdai.org/mirror/camera-modules-2.4.18-rmk7-pxa3-embedix.tar.bz2

I have read, http://people.redhat.com/arjanv/COPYING.modules
Summary: A Linux module is a derivative work unless a strong case is
made otherwise.

I would like to know if this is one of those exception cases. That is
why I used the word 'not' in the subject line.

Is sharpzdc_cs.o *not* a derivative work of Linux?


Mark Jenkins
umjenki5@cc.umanitoba.ca



Appendix A
sharpzdc_cs.o is dynamically linked against the following functions and
variables:

Symbol                    Location
--------------------------------------------
CardServices              drivers/pcmcia/cs.c
kmalloc                   mm/slab.c
__memzero                 arch/arm/lib/memzero.S
kfree                     mm/slab.c
memset                    arch/arm/lib/memset.S
memcpy                    arch/arm/lib/memcpy.S
__release_region          kernel/resource.c
sprintf                   lib/vsprintf.c
printk                    kernel/printk.c
ioport_resource           kernel/resource.c
udelay                    arch/arm/lib/delay.S
mod_timer                 kernel/resource.c
jiffies                   kernel/timer.c
register_chrdev           fs/devices.c
register_pccard_driver    drivers/pcmcia/ds.c
unregister_pccard_driver  drivers/pcmcia/ds.c
unregister_chrdev         fs/devices.c
del_timer                 kernel/timer.c

