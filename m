Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263605AbTL2Qpa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 11:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263606AbTL2Qpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 11:45:30 -0500
Received: from smtp3.libero.it ([193.70.192.127]:61083 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id S263605AbTL2QpX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 11:45:23 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16368.23199.717051.15982@gargle.gargle.HOWL>
Date: Mon, 29 Dec 2003 17:47:27 +0100
To: Duncan Sands <baldrick@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: speedtouch for 2.6.0
In-Reply-To: <200312291714.10152.baldrick@free.fr>
References: <16366.61517.501828.389749@gargle.gargle.HOWL>
	<200312291334.01173.baldrick@free.fr>
	<16368.19971.604371.882502@gargle.gargle.HOWL>
	<200312291714.10152.baldrick@free.fr>
X-Mailer: VM 7.03 under Emacs 21.2.1
From: "Guldo K" <guldo@tiscali.it>
Reply-to: "Guldo K" <guldo@tiscali.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duncan Sands writes:
 > Hi Guldo, from your email I had understood that your setup worked under
 > 2.4.  Is that right?
It's not. I didn't tell you that my previous setup (2.4)
was about the user driver, not the kernel one.

 > Anyway, the speedbundle (
 > http://linux-usb.sourceforge.net/SpeedTouch/download/index.html
 > ) contains source code for an appropriate pppd + ATM library.
Thanks.
I tried to compile just ppp, but "make" resulted in:
cd chat; make  all
make[1]: Entering directory `/tmp/speedbundle-1.0/ppp/chat'
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory `/tmp/speedbundle-1.0/ppp/chat'
cd pppd/plugins; make  all
make[1]: Entering directory `/tmp/speedbundle-1.0/ppp/pppd/plugins'
gcc -o pppoatm.so -shared -g -O2 -I.. -I../../include -fPIC pppoatm.c -latm
pppoatm.c:19:17: atm.h: No such file or directory
In file included from /usr/include/linux/atmdev.h:12,
                 from pppoatm.c:20:
/usr/include/linux/atm.h:211: error: syntax error before "uint32_t"
/usr/include/linux/atm.h:213: error: syntax error before '}' token
/usr/include/linux/atm.h:217: error: parameter `addr' has incomplete type
pppoatm.c: In function `setdevname_pppoatm':
pppoatm.c:78: error: `T2A_PVC' undeclared (first use in this function)
pppoatm.c:78: error: (Each undeclared identifier is reported only once
pppoatm.c:78: error: for each function it appears in.)
pppoatm.c:78: error: `T2A_NAME' undeclared (first use in this function)
make[1]: *** [pppoatm.so] Error 1
make[1]: Leaving directory `/tmp/speedbundle-1.0/ppp/pppd/plugins'
make: *** [all] Error 2

... and of course I don't understand anything of this....
Sorry.

*Guldo*

