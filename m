Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261613AbSJUUVT>; Mon, 21 Oct 2002 16:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261612AbSJUUVS>; Mon, 21 Oct 2002 16:21:18 -0400
Received: from funkie.transmit.com ([204.69.232.71]:61712 "EHLO
	funkie.transmit.com") by vger.kernel.org with ESMTP
	id <S261613AbSJUUVQ>; Mon, 21 Oct 2002 16:21:16 -0400
Message-Id: <5.1.0.14.0.20021021131259.0369cff0@mail.namimedia.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 21 Oct 2002 13:24:40 -0700
To: linux-kernel@vger.kernel.org
From: Ethan Joffe <ethan@toolfoundry.com>
Subject: unresolved symbols in /lib/ext3.o during boot 
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please cc as I am not subscribed to the list.

Hi.

I have a dual P3 box with 2Gigs RAM booting off onboard scsi, and I am 
having problems getting the latest v2.4.19 kernel to support the hardware 
fully. I can compile the kernel to fully support the hardware if I do not 
have it configured for 4G support, in which case it only sees 900Megs or so 
of RAM, but everything works and boots properly.
When I config for 4Gig however, the system fails to boot, giving a bunch of 
errors like the following:

/lib/ext3.0: unresolved symbol highmem_start_page
/lib/ext3.0: unresolved symbol journal_blocks_per_page_Rsmp_6082191c
/lib/ext3.0: unresolved symbol kmap_high
/lib/ext3.0: unresolved symbol journal_forget_Rsmp_678417a8
...
ERROR: /bin/insmod exited abnormally

Any idea how I can get this working properly.

Please cc as I am not subscribed to the list.

Thanks
Ethan Joffe
CTO
Nami Media Inc.

