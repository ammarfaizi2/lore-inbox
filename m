Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129719AbRC0AXD>; Mon, 26 Mar 2001 19:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129828AbRC0AWx>; Mon, 26 Mar 2001 19:22:53 -0500
Received: from phnxpop3.phnx.uswest.net ([206.80.192.3]:47108 "HELO
	phnxpop3.phnx.uswest.net") by vger.kernel.org with SMTP
	id <S129719AbRC0AWg>; Mon, 26 Mar 2001 19:22:36 -0500
Date: Mon, 26 Mar 2001 17:21:49 -0700
Message-ID: <3ABFDD1D.8DE07D1D@qwest.net>
From: "Art Wagner" <awagner@qwest.net>
To: "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre6-1 i686)
X-Accept-Language: en
MIME-Version: 1.0
Subject: 2.4.2-ac25 Compile error in es1370.c
Content-Type: multipart/mixed;
 boundary="------------A6186ABC9126EE71260F55C5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A6186ABC9126EE71260F55C5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Alan;
I got the attached compile error in /drivers/sound/es1370.c.
If any further information might be helpful please e-mail me or 
post to LKML.
Art Wagner
awagner@qwest.net
--------------A6186ABC9126EE71260F55C5
Content-Type: text/plain; charset=us-ascii;
 name="make_modules-2.4.2-ac25-1.log_clip"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="make_modules-2.4.2-ac25-1.log_clip"


make[2]: Leaving directory `/usr/src/linux-2.4.2-ac/drivers/scsi'
make[2]: Entering directory `/usr/src/linux-2.4.2-ac/drivers/video'
make -C aty modules
make[3]: Entering directory `/usr/src/linux-2.4.2-ac/drivers/usb/storage'
ld -m elf_i386 -r -o usb-storage.o scsiglue.o protocol.o transport.o usb.o initializers.o debug.o freecom.o
make[3]: Leaving directory `/usr/src/linux-2.4.2-ac/drivers/usb/storage'
make[2]: Leaving directory `/usr/src/linux-2.4.2-ac/drivers/usb'
make[3]: Entering directory `/usr/src/linux-2.4.2-ac/drivers/video/aty'
make[3]: Nothing to be done for `modules'.
make[3]: Leaving directory `/usr/src/linux-2.4.2-ac/drivers/video/aty'
make[2]: Leaving directory `/usr/src/linux-2.4.2-ac/drivers/video'
es1370.c: In function `es1370_probe':
es1370.c:2667: structure has no member named `trigger'
es1370.c:2667: structure has no member named `read'
make[2]: *** [es1370.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.2-ac/drivers/sound'
make[1]: *** [_modsubdir_sound] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.2-ac/drivers'
make: *** [_mod_drivers] Error 2

--------------A6186ABC9126EE71260F55C5--

