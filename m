Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280426AbRLDDIz>; Mon, 3 Dec 2001 22:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284204AbRLCXqa>; Mon, 3 Dec 2001 18:46:30 -0500
Received: from [203.197.145.76] ([203.197.145.76]:35593 "HELO
	mailnpd.hcltech.com") by vger.kernel.org with SMTP
	id <S284423AbRLCKpb>; Mon, 3 Dec 2001 05:45:31 -0500
Message-ID: <3C0B57A9.61A64740@npd.hcltech.com>
Date: Mon, 03 Dec 2001 16:14:57 +0530
From: Kousalya K <kkasinat@npd.hcltech.com>
Organization: HCL Tech
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-rthal5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: kkasinat@npd.hcltech.com, sagundu@npd.hcltech.com
Subject: scsi_dev_init who is calling & where its defined?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm trying to find out how linux kernel calls scsi_dev_init  function
after kernel image is loaded.
I got information  from web that , the sequence is,

"init() will call do_basic_setup() which inturn will call
        device_setup()-> scsi_dev_init()->scsi_init()"

/* init() and device_setup() are definied in main.c */

But I'm not able to find out the function call for device_setup()
(defined in /usr/src/linux-2.4.2/drivers/char/pcmcia/serial_ cb.c)
function from  do_basic_setup() function.

device_setup function is not at all calling any scsi related functions.

Could anyone please tell me the flow of how scsi_dev_init is called,
which inturn call what are all the functions?

Could you please provide the the location of the file where the
scsi_dev_init  and  scsi_init function is defined?


/* In  linux-2.4.9 kernel, I'm not able to find  out function
device_setup and also the file serial_cb.c
Any ideas?  */

Thanks ,
Kousalya



