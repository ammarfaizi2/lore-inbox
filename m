Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129428AbRBUSJg>; Wed, 21 Feb 2001 13:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129243AbRBUSJ0>; Wed, 21 Feb 2001 13:09:26 -0500
Received: from cosmos.ccrs.nrcan.gc.ca ([132.156.47.32]:51425 "EHLO
	cosmos.CCRS.NRCan.gc.ca") by vger.kernel.org with ESMTP
	id <S129134AbRBUSJP>; Wed, 21 Feb 2001 13:09:15 -0500
Message-ID: <2951561DB3DDD0118FEC00805FFE98050435E155@s5-ccr-r1>
From: "Desjardins, Kristian" <Kristian.Desjardins@CCRS.NRCan.gc.ca>
To: "'Tigran Aivazian'" <tigran@veritas.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: 128MB lost... where ?
Date: Wed, 21 Feb 2001 13:09:02 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> as you can see, the above tells you exactly how many pages you have in
> each zone and the total number of usable pages. But even that is not
> relevant to your question. What is relevant is the number 
> after the first
> "/" in the "Memory:" line and also the BIOS-e820 map, of course.
> 
> Also, on 6.4G machine you should definitely use 64G i.e. PAE 
> support and
> so if not all memory is detected, please report to this list. 
> People like
> David Parsons will probably be interested in your configuration...
> 
> Regards,
> Tigran
> 

Thanks, the problem was that I never saw the beginning of the kernel output
(dmesg) until I attached a PC and used it as a serial console.

Memory: 5917096k/6553600k available (1504k kernel code, 111824k reserved,
555k d
