Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277687AbRKFDCU>; Mon, 5 Nov 2001 22:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277700AbRKFDCK>; Mon, 5 Nov 2001 22:02:10 -0500
Received: from walden.phpwebhosting.com ([64.65.61.214]:59406 "HELO
	walden.phpwebhosting.com") by vger.kernel.org with SMTP
	id <S277687AbRKFDB5>; Mon, 5 Nov 2001 22:01:57 -0500
Message-Id: <5.1.0.14.0.20011105203703.009fd470@sunset.olemiss.edu>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 05 Nov 2001 21:00:55 -0600
To: linux-kernel@vger.kernel.org
From: Ben Pharr - Lists <ben-lists@benpharr.com>
Subject: 2.4.14: Unresolved Symbols in loop.o
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I configured 2.4.14 and then did a:

make dep clean bzImage modules modules_install

The last two lines of output were:
depmod: *** Unresolved symbols in 
/lib/modules/2.4.14/kernel/drivers/block/loop.o
depmod: 	deactivate_page

I rebooted with the new kernel and tried mounting an iso. It told me I 
didn't have loopback support. I tried a "modprobe loop" and got a 
unresolved symbol error for "deactivate_page".

Ben Pharr
ben@benpharr.com

