Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292182AbSBBBiI>; Fri, 1 Feb 2002 20:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292183AbSBBBh6>; Fri, 1 Feb 2002 20:37:58 -0500
Received: from inet-mail2.oracle.com ([148.87.2.202]:46828 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S292182AbSBBBhu>; Fri, 1 Feb 2002 20:37:50 -0500
Message-ID: <3C5B4326.856A09E6@oracle.com>
Date: Sat, 02 Feb 2002 02:38:46 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: modular floppy broken in 2.5.3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to modprobe it yields

[root@dolphin root]# modprobe floppy
/lib/modules/2.5.3/kernel/drivers/block/floppy.o: init_module: Device or resource busy
Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters
/lib/modules/2.5.3/kernel/drivers/block/floppy.o: insmod /lib/modules/2.5.3/kernel/drivers/block/floppy.o failed
/lib/modules/2.5.3/kernel/drivers/block/floppy.o: insmod floppy failed

 and dmesg says

inserting floppy driver for 2.5.3
Floppy drive(s): fd0 is 1.44M
floppy0: Floppy io-port 0x03f0 in use

I haven't been using floppy.o for some times so I can't tell
 when this broke. I'll give recent 2.5.x kernels a spin and
 report (if nobody provided other suggestions).

Thanks,
 
--alessandro

 "this machine will, will not communicate
   these thoughts and the strain I am under
  be a world child, form a circle before we all go under"
                         (Radiohead, "Street Spirit [fade out]")
