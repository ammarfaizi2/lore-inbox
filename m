Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbUKGWq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbUKGWq0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 17:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbUKGWqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 17:46:25 -0500
Received: from mail2.epfl.ch ([128.178.50.133]:59654 "HELO mail2.epfl.ch")
	by vger.kernel.org with SMTP id S261701AbUKGWqX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 17:46:23 -0500
Date: Sun, 7 Nov 2004 23:46:21 +0100
From: Gregoire Favre <Gregoire.Favre@freesurf.ch>
To: linux-kernel@vger.kernel.org
Subject: Why my computer freeze completely with xawtv ?
Message-ID: <20041107224621.GB5360@magma.epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have spend lots of time to find why my computer keep crashing (hard).

I was having a PIII@450 (don't remember the MB), then a PIV@2200 with a
MSI Max2-BLR motherboard, and now I have an amd64@3000 on an MSI Neo
K8T.

The gfx card with the PIII was a Matrox G400 and as it wasn't compatible
with the PIV I changed it for a Matrox G550.

I use DVB with VDR, but I can do the crash all the time without VDR, all
I have to do is to have xawtv running and having a process that write
fast enough data to an HD (I tested xfs, reiserfs, ext2 and ext3 with
same result). If I don't have xawtv running I can't make crashing my
system which is rock stable :-)

I have tried to put my palm on serial to see if I could grab anything
about the crash with appending 
	nmi_watchdog=1 console=ttyS0,57600 console=tty0
or with nmi_watchdog=2 but I don't receive anything.

The first problem appeared on my 2.2 kernels, and I have the same with
2.6.9 which I put under http://magma.epfl.ch/greg/linux/2.6.9-config

Please CC to me as I am not on this mailing list.
-- 
	Grégoire Favre
________________________________________________________________________
http://magma.epfl.ch/greg ICQ:16624071 mailto:Gregoire.Favre@freesurf.ch
