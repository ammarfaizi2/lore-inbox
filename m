Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293589AbSCSDPP>; Mon, 18 Mar 2002 22:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293595AbSCSDPG>; Mon, 18 Mar 2002 22:15:06 -0500
Received: from mail.getnet.net ([63.137.32.10]:58332 "HELO mail.getnet.net")
	by vger.kernel.org with SMTP id <S293589AbSCSDOx>;
	Mon, 18 Mar 2002 22:14:53 -0500
Message-ID: <3C96ACD1.9010306@westek-systems.com>
Date: Tue, 19 Mar 2002 03:13:21 +0000
From: Art Wagner <awagner@westek-systems.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9+) Gecko/20020315
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.7 oss modules compile error
Content-Type: multipart/mixed;
 boundary="------------070203090300090803060006"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070203090300090803060006
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I encountered the attached error whie compiling 2.5.7 with the oss sound 
modules
configured. The "_not_defined_use_pci_map" portion of the failing statement
seems to be defined in ./include/asm-i386/io.h, line 117.
Art Wagner

--------------070203090300090803060006
Content-Type: text/plain;
 name="Compile error.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Compile error.txt"

drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/char/agp/agp.o drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o sound/sound.o drivers/pci/driver.o drivers/pnp/pnp.o drivers/video/video.o drivers/usb/usbdrv.o drivers/input/inputdrv.o \
	net/network.o \
	--end-group \
	-o vmlinux
sound/sound.o: In function `sound_alloc_dmap':
/usr/src/linux-2.5.7/sound/oss/dmabuf.c:116: undefined reference to `virt_to_bus_not_defined_use_pci_map'
make: *** [vmlinux] Error 1

--------------070203090300090803060006--

