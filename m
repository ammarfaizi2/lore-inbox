Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261305AbSLTLA4>; Fri, 20 Dec 2002 06:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261398AbSLTLAz>; Fri, 20 Dec 2002 06:00:55 -0500
Received: from prosun.first.gmd.de ([194.95.168.2]:21510 "EHLO
	prosun.first.gmd.de") by vger.kernel.org with ESMTP
	id <S261305AbSLTLAz>; Fri, 20 Dec 2002 06:00:55 -0500
From: sonne@prosun.first.gmd.de (Soeren Sonnenburg)
Message-Id: <200212201108.MAA19448@pille.first.gmd.de>
Subject: harddisk freeze on 2.4.20
To: linux-kernel@vger.kernel.org
Date: Fri, 20 Dec 2002 12:08:57 +0100 (MET)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
My current setup is A7V8x 2 WDC 180GB disks in raid0, both are masters
 (without slaves) on the primary and secondary onboard VT8235 controller.
The drives are attached at the connector in the middle of the cable.

When doing a badblock scan of /dev/hda and /dev/hdc the primary master
 disk freezes from time to time, i.e.
it is not accessible anymore/coldfreeze of the system ... even after
 a cold reboot the bios complains "primary master fails".
A powerdown / poweron cycle fixes this.

I am not sure whether the reason is cable/DMA/bios of the harddisk/bios/or
linux ide drivers. However to find out the exact cause of this problem I am
grateful for hints on how to find out where the problem lies...

I already tried a different cable for the primary master disk... still the
same problem occurs.

Thanks,
Soeren.
