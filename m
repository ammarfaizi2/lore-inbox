Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264949AbUAVUjI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 15:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266298AbUAVUjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 15:39:08 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:15591 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id S264949AbUAVUjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 15:39:04 -0500
Message-ID: <401034E6.70703@t-online.de>
Date: Thu, 22 Jan 2004 21:39:02 +0100
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.1 on ATI Rage 128 M3: some thin vertical lines show up
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Seen: false
X-ID: bROMHQZBZe7bJ0Aa1eT++P8VnNXFSzWVWSRRDwDvI34+Pq39K6emcB
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Kernel: plain 2.6.1, booted with "vga=0x318"
Hardware: Dell C600 laptop
VGA: VGA compatible controller: ATI Technologies Inc Rage Mobility M3 AGP 2x (rev 02)
      (XFree86 says '"ATI Rage 128 Mobility M3 LF (AGP)" (ChipID = 0x4c46)')

If I run "make menuconfig" on the frame buffer console,
then some character cells (e.g. the top line to the right
of "Linux Kernel v2.6.1 Configuration") contain some thin
vertical lines in various colors instead of being plain blue.

Switching to another console and back to the menuconfig screen
does a clean-up, but new screen output will create the thin
vertical lines again.

It seems that only the character cells _without_ printed text
contain the thin lines. The same problem comes up with
running aptitude instead of menuconfig.

I can't remember having seen this problem with kernel 2.4.22,
but please don't count on this. Can anybody reproduce this
problem?


Regards

Harri
