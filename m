Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129657AbQKAAxX>; Tue, 31 Oct 2000 19:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129753AbQKAAxN>; Tue, 31 Oct 2000 19:53:13 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:53509 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129657AbQKAAw6>;
	Tue, 31 Oct 2000 19:52:58 -0500
Message-ID: <39FF6965.C2FB312D@mandrakesoft.com>
Date: Tue, 31 Oct 2000 19:52:53 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Randy Dunlap <randy.dunlap@intel.com>
CC: Linus Torvalds <torvalds@transmeta.com>, Keith Owens <kaos@ocs.com.au>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test10-pre7 (LINK ordering)
In-Reply-To: <Pine.LNX.4.10.10010311257510.22165-100000@penguin.transmeta.com> <39FF60D2.8FE0E42E@intel.com>
Content-Type: multipart/mixed;
 boundary="------------5D7BDBA9694D43A16CA1F231"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------5D7BDBA9694D43A16CA1F231
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Randy Dunlap wrote:
> With CONFIG_USB=y and all other USB modules built as
> modules (=m), linking usbdrv.o into the kernel image
> gives this:

> drivers/usb/usbdrv.o(.data+0x2f4): undefined reference to

Works for me here, .config attached.  Local changes, merge error, or
similar?  I don't have any local USB patches...

-- 
Jeff Garzik             | "Mind if I drive?"  -Sam
Building 1024           | "Not if you don't mind me clawing at the
MandrakeSoft            |  dash and shrieking like a cheerleader."
                        |                     -Max
--------------5D7BDBA9694D43A16CA1F231
Content-Type: application/octet-stream;
 name="config.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="config.bz2"

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
f/F3JFOFCQPOwuTQ
--------------5D7BDBA9694D43A16CA1F231--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
