Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278940AbRKDVMj>; Sun, 4 Nov 2001 16:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278958AbRKDVM3>; Sun, 4 Nov 2001 16:12:29 -0500
Received: from zeus.kernel.org ([204.152.189.113]:6334 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S278940AbRKDVMQ>;
	Sun, 4 Nov 2001 16:12:16 -0500
Message-ID: <3BE59D75.E8D9712C@schrod.net>
Date: Sun, 04 Nov 2001 20:56:37 +0100
From: Klaus Schrod <klaus@schrod.net>
Reply-To: klaus@schrod.net
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: depmod problems with 2.4.14-pre8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

problem: after compiling the problem the depmod failed while doing
         'make modules_install'.

error report:
depmod: *** Unresolved symbols in
/lib/modules/2.4.14-pre8/kernel/drivers/char/joystick/serport.o
depmod:         serio_unregister_port_R9b5ab377
depmod:         serio_register_port_Rc0424a02


kschrod@hydra:/source-archive/kernel > gcc -v
Reading specs from /usr/lib/gcc-lib/i486-suse-linux/2.95.2/specs
gcc version 2.95.2 19991024 (release)

You can download my config file from
http://www.schrod.net/linux/config.2.4.24-pre8

If you need any additional information do not esitate to contact me.

I could compile the kernel and the modules with success.

Klaus

P.S.: I do not use the kernel yet. I hope that this was the 
only error report ;-)


