Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbTL2Pvj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 10:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263491AbTL2Pvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 10:51:39 -0500
Received: from smtp1.libero.it ([193.70.192.51]:61069 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id S263475AbTL2Pvh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 10:51:37 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16368.19971.604371.882502@gargle.gargle.HOWL>
Date: Mon, 29 Dec 2003 16:53:39 +0100
To: Duncan Sands <baldrick@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: speedtouch for 2.6.0
In-Reply-To: <200312291334.01173.baldrick@free.fr>
References: <16366.61517.501828.389749@gargle.gargle.HOWL>
	<200312291334.01173.baldrick@free.fr>
X-Mailer: VM 7.03 under Emacs 21.2.1
From: "Guldo K" <guldo@tiscali.it>
Reply-to: "Guldo K" <guldo@tiscali.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > It works the same as the module in 2.4.22 and later.
 > This module was originally only available outside the
 > kernel tree (it can be found for example in the
 > speedbundle on http://linux-usb.sf.net/SpeedTouch).
 > Now that it is in the kernel tree it is pointless to
 > compile it in the speedbundle (and it doesn't work
 > right now for 2.6 kernels).  Just turn it on in your
 > kernel .config and recompile your kernel.

Thanks for your anwser.
I loaded all modules:
Module                  Size  Used by
uhci_hcd               30928  0 
speedtch               14096  0 
crc32                   4320  1 speedtch
tdfx                   37096  0 
pcspkr                  3300  0 
tdfxfb                 12456  0 
cfbimgblt               3136  1 tdfxfb

then configured all necessary files.
All fine. Nice green lights.

But when I ran pppd, I got:
pppd: /usr/lib/pppd/plugins/pppoatm.so:
 cannot open shared object file: No such file or directory
pppd: Couldn't load plugin /usr/lib/pppd/plugins/pppoatm.so

I looked for it and noticed it was in /usr/lib/pppd/2.4.20/,
so I linked it; but then I got:
pppd: libatm.so.1: cannot open shared object file: No such file or directory
pppd: Couldn't load plugin /usr/lib/pppd/plugins/pppoatm.so

Looks like I missed some piece of installation...

Could you help me?

Grazie,

*Guldo*

