Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264781AbUEPSjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264781AbUEPSjA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 14:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264782AbUEPSjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 14:39:00 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:18116 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264781AbUEPSi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 14:38:58 -0400
Date: Sun, 16 May 2004 20:38:49 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.6-mm3: USB console.c doesn't compile
Message-ID: <20040516183849.GO22742@fs.tum.de>
References: <20040516025514.3fe93f0c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040516025514.3fe93f0c.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following compile error comes from Linus' tree:

<--  snip  -->

...
  CC      drivers/usb/serial/console.o
drivers/usb/serial/console.c: In function `usb_console_setup':
drivers/usb/serial/console.c:140: warning: implicit declaration of function `serial_paranoia_check'
...
  LD      .tmp_vmlinux1
drivers/built-in.o(.init.text+0x698c8): In function `usb_console_setup':
: undefined reference to `serial_paranoia_check'
make: *** [.tmp_vmlinux1] Error 1

<--  snip   -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

