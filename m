Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266586AbSKLOjX>; Tue, 12 Nov 2002 09:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266626AbSKLOjX>; Tue, 12 Nov 2002 09:39:23 -0500
Received: from [195.110.114.159] ([195.110.114.159]:7463 "EHLO trinityteam.it")
	by vger.kernel.org with ESMTP id <S266586AbSKLOjX>;
	Tue, 12 Nov 2002 09:39:23 -0500
Date: Tue, 12 Nov 2002 15:52:09 +0100
Message-Id: <200211121452.gACEq9G09512@trinityteam.it>
From: Ricci Daniele <ricci@trinityteam.it>
To: linux-kernel@vger.kernel.org
Subject: PDC20276 Linux driver
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a Gigabyte 7DPXDW-P, a dual Athlon motherboard whit a FastTrak
controller onboard and I found some difficulties installing the driver.
Kernel deviceses initialization recognise my PDC20276 controller and find
the disks connected (/dev/hde and /dev/hdg) and the array I made with them
(/dev/ataraid/d0 RAID1). I tryed to write in /dev/ataraid/d0 but after about
half a gigabyte written, the system stops to write and the process(es) writing
appare(s) in the outputo of ps with the flag D (IO waiting). After a lot of
tryes I tryed to write in /dev/hde and /dev/hdg at different times, but the
same thing happens.
Is the problem in the FastTrak driver, in the PDC20276 driver, or in my
hardware?
Is there a known bug?
Do somebody has the same mothrboard and can use PDC20276? If yes, can u tell
me how to do?

How can I do to debug degug the ide driver or the PDC driver? Or What
documentation have I to read?

Thank you for your time,
Daniele.
