Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269354AbRHLQJd>; Sun, 12 Aug 2001 12:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269355AbRHLQJY>; Sun, 12 Aug 2001 12:09:24 -0400
Received: from mailgate.FH-Aachen.DE ([149.201.10.254]:12789 "EHLO
	mailgate.fh-aachen.de") by vger.kernel.org with ESMTP
	id <S269354AbRHLQJO>; Sun, 12 Aug 2001 12:09:14 -0400
Posted-Date: Sun, 12 Aug 2001 18:04:08 +0100 (WEST)
Date: Sun, 12 Aug 2001 18:09:20 +0200
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200108121609.SAA05624@db0bm.ampr.org>
To: linux-kernel@vger.kernel.org
Subject: nVidia Riva frame buffers and resolution selection
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I use both 2.2pre20 and 2.4.8-ac1.
I've a Riva TNT2 card.
I use frame buffers with both.
With 2.4, there is a nVidia Riva support, not with 2.2.
I've a big display and I use a resolution of 1024 x 768.

With 2.2, it is unaccelerated but I cat set all the VT the same resolution at
once with 'vga=0x318' in an append line of lilo of with grub.

With 2.4, the only way I've found is to use fbset in a start script,
unfortunately, this does not switch all the VT ay once ; especially the screen
with no login (i.e. the syslog I redirect to tty12).

Is there a mean to switch all the VT to the same resolution when the nVidia
Riva frame buffer is activated.
------------
Regards
		Jean-Luc
