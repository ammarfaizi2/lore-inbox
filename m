Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbVLXXji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbVLXXji (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 18:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbVLXXji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 18:39:38 -0500
Received: from lucidpixels.com ([66.45.37.187]:36250 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1750756AbVLXXjh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 18:39:37 -0500
Date: Sat, 24 Dec 2005 18:39:37 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: linux-kernel@vger.kernel.org
Subject: Using Intel ICH5 IDE+SATA Under 2.6.15-rc6 - Cannot find DVD-RW?
Message-ID: <Pine.LNX.4.64.0512241837120.2700@p34>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The BIOS see's my drive without any issues.

My config: [AUTO, allow for up to 6 devices on IDE/SATA total]

p34:~# cat /dev/hdc
cat: /dev/hdc: No such device or address
p34:~# cat /dev/sdc
cat: /dev/sdc: No such device or address
p34:~#

p34:~# dmesg | grep NEC
p34:~#

CONFIG =

SATA1 -> RAPTOR
SATA2 -> SEAGATE
IDE0 -> NOTHING
IDE1 -> MASTER (DVDRW/CDRW)

But for some reason the kernel is not seeing it?


