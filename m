Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130147AbQJ0Cg3>; Thu, 26 Oct 2000 22:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130222AbQJ0CgJ>; Thu, 26 Oct 2000 22:36:09 -0400
Received: from web6105.mail.yahoo.com ([128.11.22.99]:59910 "HELO
	web6105.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129962AbQJ0Cf7>; Thu, 26 Oct 2000 22:35:59 -0400
Message-ID: <20001027023557.20423.qmail@web6105.mail.yahoo.com>
Date: Thu, 26 Oct 2000 19:35:57 -0700 (PDT)
From: Hunt Kent <kenthunt@yahoo.com>
Subject: Re: test[9-10] USB depmod unresolved symbols
To: linux kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, updates:

        Compiled modutils 2.3.19 and the problem
persists.
Arch is i386, AMD K-6.

        Result for modprobe -ae (test10-pre5):

depmod: *** Unresolved symbols in
/lib/modules/2.4.0-test10-pre5/kernel/drivers/usb/dc2xx.o
depmod:         usb_bulk_msg
depmod:         usb_deregister
depmod:         usb_free_dev
depmod:         usb_inc_dev_use
depmod:         usb_register
depmod: *** Unresolved symbols in
/lib/modules/2.4.0-test10-pre5/kernel/drivers/usb/ov511.o
depmod:         usb_deregister
depmod:         usb_free_urb
depmod:         usb_alloc_urb
depmod:         usb_register
depmod:         usb_submit_urb
depmod:         usb_driver_release_interface
depmod:         usb_control_msg
depmod:         usb_set_interface
depmod:         usb_unlink_urb
depmod: *** Unresolved symbols in
/lib/modules/2.4.0-test10-pre5/kernel/drivers/usb/printer.o
depmod:         usb_deregister
depmod:         usb_register
depmod:         usb_submit_urb
depmod:         usb_set_interface
depmod:         usb_unlink_urb
depmod: *** Unresolved symbols in
/lib/modules/2.4.0-test10-pre5/kernel/drivers/usb/scanner.o
depmod:         usb_bulk_msg
depmod:         usb_deregister
depmod:         usb_register
depmod:         usb_submit_urb
depmod:         usb_driver_release_interface
depmod:         usb_unlink_urb

        Let me know if you need more info.


__________________________________________________
Do You Yahoo!?
Yahoo! Messenger - Talk while you surf!  It's FREE.
http://im.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
