Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266259AbUALVNg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 16:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266262AbUALVNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 16:13:34 -0500
Received: from main.gmane.org ([80.91.224.249]:48853 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266259AbUALVNN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 16:13:13 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jens Benecke <jens-usenet@spamfreemail.de>
Subject: 2.6.1mm2: very bad interactive behaviour under XFree86
Date: Mon, 12 Jan 2004 22:13:18 +0100
Message-ID: <2867040.OKCKYgd4AF@spamfreemail.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: KNode/0.7.6
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

running an up-to-date XFree86 4.3 from Debian unstable, I have a stuck mouse
pointer in X11 every time some application uses 100% CPU. I have
folding@home running in the background at nice 19, which doesn't disturb
anything, but when my machine starts up the following happens:

- KDE 3.2 boots up,
- openoffice quickstart,
- KGpg reads a couple thousand keys,
- xmms, xosview, background picture, etc load up
- about 10 cm worth of applets in the KDE panel start

During this time (20-30sec) the mouse pointer jerks from position to
position about once to twice a second. My X server runs at priority 0, not
-10, as recommended. This has been the case since 2.6.0-test11, but I have
the (subjective) impression that under 2.6.1rc1-mm1 and 2.6.1-mm2 it got
worse.

I am using an Athlon XP 2600+ with 1024MB RAM, Nforce2 chipset, NVIDIA
XFree86 drivers.


Shall I try vanilla 2.6.1 and compare? Or is this an obvious problem?


Thanks!



-- 
Jens Benecke
