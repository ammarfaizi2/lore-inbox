Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266307AbSKGC73>; Wed, 6 Nov 2002 21:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266309AbSKGC73>; Wed, 6 Nov 2002 21:59:29 -0500
Received: from redtux.demon.co.uk ([158.152.117.135]:53260 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S266307AbSKGC72>; Wed, 6 Nov 2002 21:59:28 -0500
Subject: problem with unresolved symbols 2.5.46
From: mike <mike@redtux.demon.co.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1036638244.19136.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.2.99 (Preview Release)
Date: 07 Nov 2002 03:04:23 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am, getting the following error at the end of a kernel compile

make -f scripts/Makefile.modinst obj=arch/i386/lib
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.46; fi
depmod: *** Unresolved symbols in
/lib/modules/2.5.46/kernel/drivers/char/raw.o
depmod:         blkdev_ioctl

I have tried with gcc 3.2 and 2.96 no difference
-- 
Linux, Gnome what more do you need
http://www.redtux.demon.co.uk
