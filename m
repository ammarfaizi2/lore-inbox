Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265656AbTFNNHC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 09:07:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265661AbTFNNHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 09:07:02 -0400
Received: from athmta01.forthnet.gr ([193.92.150.23]:2420 "EHLO forthnet.gr")
	by vger.kernel.org with ESMTP id S265656AbTFNNHA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 09:07:00 -0400
Date: Sat, 14 Jun 2003 16:20:42 +0300
From: fsck <fsck@www0.org>
To: linux-kernel@vger.kernel.org
Subject: fbdev+apm hangs & disabled serial on old thinkpads
Message-ID: <20030614132042.GA481@www0.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this concerns an old thinkpad laptop, the 560e, running linux 2.4.20
& 21, but I guess there may be similar cases on other machines. the
video card is a Trident TGUI 9660/968x/968x (rev d3) and the serial
UART a typical 16550A.

the first problem is that with apm loaded all power features including
shutdown work perfectly. with fbdev on, shutdown and suspend/standby
features hang the machine. this is important since on that old machines
using 'links' and 'mplayer' with fbdev support, make linux an ease to
use. 

q1: are there any details available for that kind of hangs?

the second problem is that /dev/tts/1 goes hardware disabled on some
rare cases after a boot. resetting the bios and removing all power
supply keeps the disabling on. On windows, device manager shows "code
22, device disabled" and turning it on from that OS, makes it work
again running linux.

q2: since the disabling didn't happened using windows but that OS
detected it, is there a similar way for linux, to enable devices?

-fsck
