Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbUL0Fky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbUL0Fky (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 00:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbUL0Fky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 00:40:54 -0500
Received: from orcas.net ([66.92.223.130]:36259 "EHLO orcas.net")
	by vger.kernel.org with ESMTP id S261752AbUL0Fkt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 00:40:49 -0500
Date: Sun, 26 Dec 2004 21:32:24 -0800 (PST)
From: Terry Hardie <terryh@orcas.net>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Asus P4C800-E Deluxe and Intel Pro/1000
In-Reply-To: <200411112003.43598.Gregor.Jasny@epost.de>
Message-ID: <Pine.LNX.4.58.0412262127510.3478@orcas.net>
References: <6.1.1.1.0.20041108074026.01dead50@ptg1.spd.analog.com>
 <200411112003.43598.Gregor.Jasny@epost.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, this has been plauging me for months, and finally figured it out.

Any 2.6 kernel on my board, would boot, then give errors (paraphrased,
sorry) when I tried to bring up the ethernet:

NETDEV WATCHDOG: eth0: transmit timed out
IRQ #18: Nobody cared!

And no ethernet conectivity.

The Fix: Update bios from asus' website. I guess their ACPI was screwed
up. This is the second time I've had to update this MB to fix
incompatibilities with Linux. So, watch out with Asus boards on Linux.

BTW - Linux 2.4's driver worked fine with the old bios. Only 2.6 didn't
work.


---
Terry Hardie					terry@net.com
SHOUTip System Architect & Principal Engineer	ICQ#: 977679
net.com, 6900 Paseo Padre Parkway
Fremont, CA 94555, USA				V: +1-510-574-2366
