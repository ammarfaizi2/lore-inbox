Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbTEHHAI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 03:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbTEHHAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 03:00:08 -0400
Received: from mail-out2.apple.com ([17.254.0.51]:62407 "EHLO
	mail-out2.apple.com") by vger.kernel.org with ESMTP id S261196AbTEHHAH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 03:00:07 -0400
Date: Thu, 8 May 2003 00:12:36 -0700 (PDT)
From: Dave Zarzycki <dave@zarzycki.org>
To: linux-kernel@vger.kernel.org
Subject: PCI-X/Ultra320/RAID tuning problem?
Message-ID: <Pine.OSX.4.44.0305071941490.2203-100000@rikku.zarzycki.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the following setup, which is performing below my expectations.
I was wondering if any of the list subscribers could provide any tuning
tips:

Red Hat Linux 9
Tyan Thunder i7501 Pro (S2721-533) motherboard
2GB RAM
8 Ultra320 Seagate 15k.3 drives, 4 on each Ultra320 channel
no additional PCI/PCI-X devices installed

dmesg:   http://zarzycki.org/~dave/dmesg

lspci -vvv:   http://zarzycki.org/~dave/lspci-vv.out

These lines in the dmesg output seem troubling:

aic79xx: PCI4:2:1 MEM region 0x0 unavailable. Cannot memory map device.
aic79xx: PCI4:2:0 MEM region 0x0 unavailable. Cannot memory map device.

I seem to be topping out at 200 to 255MB/s depending on the setup
(messured with hdparm -t and dd), while each drive is capable of 72MB/s.
Dual Ultra320 with PCI-X should do better than this, right? I'd estimate
500+ MB/s given this setup. Am I being unreasonable?

Thanks for any help.

davez

-- 
Dave Zarzycki
http://zarzycki.org/~dave/



