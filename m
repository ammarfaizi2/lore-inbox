Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267742AbSLGKGv>; Sat, 7 Dec 2002 05:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267743AbSLGKGv>; Sat, 7 Dec 2002 05:06:51 -0500
Received: from postfix3-1.free.fr ([213.228.0.44]:52435 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP
	id <S267742AbSLGKGu>; Sat, 7 Dec 2002 05:06:50 -0500
Date: Sat, 7 Dec 2002 11:13:30 +0100
From: Romain Lievin <rlievin@free.fr>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tiglusb: *** Unresolved symbols in tiglusb.o
Message-ID: <20021207101330.GD494@free.fr>
References: <20021204200318.GA933@free.fr> <20021204220127.GB29145@kroah.com> <20021205193009.GD369@free.fr> <20021206191921.GC11078@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021206191921.GC11078@kroah.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

a TiLP's user reported me something strange I never noticed because the module
compiles fine and is loaded fine with insmod/modprobe, too.

But, when he does a depmod -a, he get the following stuffs:

laurel:/home/devel/timodules_project/tiser# update-modules
depmod: *** Unresolved symbols in /lib/modules/2.4.19/kernel/drivers/usb/tiglusb.o
laurel:/home/devel/timodules_project/tiser# depmod -ae
depmod: *** Unresolved symbols in /lib/modules/2.4.19/kernel/drivers/usb/tiglusb.o
depmod:         schedule_timeout
depmod:         __wake_up
depmod:         __generic_copy_from_user
depmod:         usb_bulk_msg
depmod:         unregister_chrdev
depmod:         register_chrdev
depmod:         usb_deregister
depmod:         no_llseek
depmod:         sleep_on
depmod:         usb_register
depmod:         usb_set_configuration
depmod:         sprintf
depmod:         printk
depmod:         usb_clear_halt
depmod:         __generic_copy_to_user

Why do I get this ?

Thanks, Romain.
-- 
Romain Lievin, aka 'roms'  	<roms@tilp.info>
The TiLP project is on 		<http://www.ti-lpg.org>
"Linux, y'a moins bien mais c'est plus cher !"














