Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266347AbSLIVhe>; Mon, 9 Dec 2002 16:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266353AbSLIVhd>; Mon, 9 Dec 2002 16:37:33 -0500
Received: from [209.195.52.120] ([209.195.52.120]:44528 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id <S266347AbSLIVhc>; Mon, 9 Dec 2002 16:37:32 -0500
From: David Lang <david.lang@digitalinsight.com>
To: linux-kernel@vger.kernel.org
Date: Mon, 9 Dec 2002 13:33:40 -0800 (PST)
Subject: Adaptec 2940 not working on 2.5.50
In-Reply-To: <523223727.20021209222741@linux01.gwdg.de>
Message-ID: <Pine.LNX.4.44.0212091324430.31621-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

after watching from the sidelines for a while I finally had some time to
try the 2.5 kernels over the weekend.

unfortunantly I was unable to build a kernel that will work for me.

the system is a K6-3 400 with several IDE drives and a SCSI drive hooked
to an adaptec 2940. LILO and the boot kernels are on IDE, but the linux
root filesystem is on the SCSI drive

I compile the kernel without a problem, but when it boots it generates
several screens of errors as it attempts to initialize the SCSI buss.
unfortunantly I don't have a serial console on that box so I haven't been
able to capture the messages (I can't capture dmesg becouse the system
never finds the drive and so can't complete the boot)

I have verbose errors turned on, and have attempted both the old and the
new drivers with the same results.

this system ran 2.4.0 up until about two months ago when I upgraded to
2.4.18 and has had no problems.

a quick google search has not found any posts about this, although
2.5.50-ac1 has a fix for this driver (doesn't sound like quite the same
problem though)

suggestions? additional info required?

David Lang
