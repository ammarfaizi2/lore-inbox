Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267426AbSLSAYg>; Wed, 18 Dec 2002 19:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267409AbSLSAYf>; Wed, 18 Dec 2002 19:24:35 -0500
Received: from modemcable088.111-203-24.mtl.mc.videotron.ca ([24.203.111.88]:30679
	"EHLO nestor.salz.wox.org") by vger.kernel.org with ESMTP
	id <S267431AbSLSAX1>; Wed, 18 Dec 2002 19:23:27 -0500
Subject: cmpci: microphone/line in not working
From: Pierre-Marc Fournier <pmf@users.sourceforge.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 18 Dec 2002 19:31:29 -0500
Message-Id: <1040257890.1248.62.camel@piteu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, my microphone does not work with my c-media CM8738 (builtin in
asus a7v333 motherboard).
Using kernel 2.4.18

Adjusted mixer properties so that the recording input is the microphone.
Volume is at max for microphone (play and record). No hardware mute on
the microphone. I should be hearing the mike in the speakers without
even recording, right?

Recording gives no error, but only silence is recorded.
Used gnome-sound-recorder for the tests

Everything works fine on other OS with exact same hardware
configuration.

The cmpci v.5.64 gave me this error, while trying to record I think, but
it does not do so at every attempt.
cmpci: read: chip lockup? dmasz 65536 fragsz 256 count 0 hwptr 0 swptr 0

Tried latest: v.5.68; didn't give the error but I'm not sure it won't
ever since I'm not able to reproduce it on v.5.64 (It just happens
sometimes.)

Here's the startup output. Apart from the error, there are no other
messages from the driver. 5.64 output is basically the same.

cm: version $Revision: 5.68 $ time 18:26:47 Dec 18 2002
PCI: Found IRQ 10 for device 00:05.0
PCI: Sharing IRQ 10 with 00:09.2
cm: found CM8738 adapter at io 0xb800 irq 10
chip version = 055
cm: Enable SPDIF loop

Audio output works perfectly.

Any help appreciated.
Thanks
Pierre

