Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263033AbRE1I36>; Mon, 28 May 2001 04:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263018AbRE1I3s>; Mon, 28 May 2001 04:29:48 -0400
Received: from [212.183.11.206] ([212.183.11.206]:16905 "EHLO
	grips_nts2.grips.com") by vger.kernel.org with ESMTP
	id <S263012AbRE1I32>; Mon, 28 May 2001 04:29:28 -0400
Message-ID: <3B120C52.5360B863@grips.com>
Date: Mon, 28 May 2001 10:29:06 +0200
From: jury gerold <geroldj@grips.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-xfs2 i686)
X-Accept-Language: de-AT, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: usb net1080.c vendor/device id
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

in kernel 2.4.3 2.4.4 2.4.5

In drivers/usb/net1080.c somewhere near line 61 i see the following

	{ USB_DEVICE(0x1080, 0x525), 

the vendor and device id are reversed.
I have changed this to

	{ USB_DEVICE(0x525, 0x1080), 
and it worked since then.
I have checked it against the id database on http://www.linux-usb.org/usb.ids
Dear usb maintainer's, please change it.

best regards

Gerold
