Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264203AbRFDLUL>; Mon, 4 Jun 2001 07:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264202AbRFDLUA>; Mon, 4 Jun 2001 07:20:00 -0400
Received: from 209.102.21.2 ([209.102.21.2]:16913 "EHLO dragnet.seagull.net")
	by vger.kernel.org with ESMTP id <S264201AbRFDLTx>;
	Mon, 4 Jun 2001 07:19:53 -0400
Message-ID: <3B1B353A.CCD03B34@goingware.com>
Date: Mon, 04 Jun 2001 07:14:02 +0000
From: "Michael D. Crawford" <crawford@goingware.com>
Organization: GoingWare Inc. - Expert Software and Consulting
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: tulip works in 2.4.5 on Compaq Presario 1800T (was broken)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With a number of previous kernel versions, the tulip driver would not
work with the digital DS21143 ethernet controller that comes bundled
with the Compaq Presario 1800T laptop.

Fortunately, the de4x5 driver would work with it, however the situation
was confusing because the config doc supplied for the de4x5 driver
doesn't mention that it supports tulip chips now also, while the tulip
driver claimed that it should work.  Further if one compiled both into
the kernel, the tulip driver would initialize first and claim control of
the chip and prevent the de4x5 from working.

I hadn't tried the tulip driver on my laptop for a few kernel versions
so I don't know when it started working.  But it works now, with 2.4.5. 
de4x5 also works.  So you can use either one.

Curiously, when I first installed Linux on my laptop, I think it was
Slackware 4.0, I couldn't get any driver to work, but I got a
development version of the author's site, and it worked OK in a 2.2
kernel.  But later versions that were actually rolled into the kernel
didn't work.

I have a page about linux on my Compaq Presario 1800T at

http://www.goingware.com/laptop/linux/

I've gotten quite a few emails from confused 1800T owners in the time
I've had that page up, I think this will make things much easier.

Regards,

Michael D. Crawford
GoingWare Inc. - Expert Software Development and Consulting
http://www.goingware.com/
crawford@goingware.com

   Tilting at Windmills for a Better Tomorrow.
