Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131168AbQKAChB>; Tue, 31 Oct 2000 21:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131178AbQKACgv>; Tue, 31 Oct 2000 21:36:51 -0500
Received: from ganymede.or.intel.com ([134.134.248.3]:783 "EHLO
	ganymede.or.intel.com") by vger.kernel.org with ESMTP
	id <S131168AbQKACgo>; Tue, 31 Oct 2000 21:36:44 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDBE4@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Jeff Garzik'" <jgarzik@mandrakesoft.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Keith Owens <kaos@ocs.com.au>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: test10-pre7 (LINK ordering)
Date: Tue, 31 Oct 2000 17:13:40 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > With CONFIG_USB=y and all other USB modules built as
> > modules (=m), linking usbdrv.o into the kernel image
> > gives this:
> 
> > drivers/usb/usbdrv.o(.data+0x2f4): undefined reference to
> 
> Works for me here, .config attached.  Local changes, merge error, or
> similar?  I don't have any local USB patches...

I agree.  My (rushed) bad.
Didn't rm usb/*.o .

Thanks for catching me.  I'm pleased that there's
no problem here.

~Randy

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
