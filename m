Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271213AbRICETc>; Mon, 3 Sep 2001 00:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271214AbRICETX>; Mon, 3 Sep 2001 00:19:23 -0400
Received: from mail.triton.net ([216.65.160.10]:7181 "HELO mail.triton.net")
	by vger.kernel.org with SMTP id <S271213AbRICETG>;
	Mon, 3 Sep 2001 00:19:06 -0400
Message-ID: <3B9304C5.4070006@lycosmail.com>
Date: Mon, 03 Sep 2001 00:19:17 -0400
From: Adam Schrotenboer <ajschrotenboer@lycosmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, LKML <linux-kernel@vger.kernel.org>,
        Keith Owens <kaos@sherman.melbourne.sgi.com>
Subject: scsi_lib.c undefined symbol
Content-Type: multipart/mixed;
 boundary="------------050701070104010809000306"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050701070104010809000306
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I have gotten this a couple times w/ other versions of the kernel, but 
this is 2.4.9-ac6. (2.4.8-ac12 worked, but that may be a fluke)

Keith, if you say that this is b0rken Makefiles, it shouldn't be, b/c 
this is after a make mrproper.

My config is gzipped and attached to the end of this e-mail.

I don't actually have any SCSI devices. I want scsi for ide-scsi (DVD 
drive) and a USB CDRW.
Help, please.

gcc -D__KERNEL__ -I/mnt/hda3/kernel/2.4.9-ac6/linux/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=athlon  -DMODULE -DMODVERSIONS -include 
/mnt/hda3/kernel/2.4.9-ac6/linux/include/linux/modversions.h   -c -o 
scsi_lib.o scsi_lib.c
scsi_lib.c: In function `__scsi_end_request':
scsi_lib.c:379: `queued_sectors_Rc37b18c1' undeclared (first use in this 
function)
scsi_lib.c:379: (Each undeclared identifier is reported only once
scsi_lib.c:379: for each function it appears in.)
make[2]: *** [scsi_lib.o] Error 1
make[2]: Leaving directory `/mnt/hda3/kernel/2.4.9-ac6/linux/drivers/scsi'
make[1]: *** [_modsubdir_scsi] Error 2
make[1]: Leaving directory `/mnt/hda3/kernel/2.4.9-ac6/linux/drivers'
make: *** [_mod_drivers] Error 2


--------------050701070104010809000306
Content-Type: application/octet-stream;
 name=".config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename=".config.gz"

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
--------------050701070104010809000306--

