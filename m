Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbTELUqL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 16:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262676AbTELUqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 16:46:11 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:61386 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262609AbTELUqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 16:46:10 -0400
Date: Mon, 12 May 2003 22:58:48 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: David Brownell <david-b@pacbell.net>, Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.69-bk7: multiple definition of `usb_gadget_get_string'
Message-ID: <20030512205848.GU1107@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<--  snip  -->

...
   ld -m elf_i386  -r -o drivers/usb/gadget/built-in.o 
drivers/usb/gadget/net2280.o drivers/usb/gadget/g_zero.o 
drivers/usb/gadget/g_ether.o
drivers/usb/gadget/g_ether.o(.text+0x1f60): In function 
`usb_gadget_get_string':
: multiple definition of `usb_gadget_get_string'
drivers/usb/gadget/g_zero.o(.text+0x0): first defined here
make[2]: *** [drivers/usb/gadget/built-in.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

