Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263152AbREaSja>; Thu, 31 May 2001 14:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263157AbREaSjU>; Thu, 31 May 2001 14:39:20 -0400
Received: from smtp3.xs4all.nl ([194.109.127.132]:50695 "EHLO smtp3.xs4all.nl")
	by vger.kernel.org with ESMTP id <S263152AbREaSjO>;
	Thu, 31 May 2001 14:39:14 -0400
From: thunder7@xs4all.nl
Date: Thu, 31 May 2001 20:39:08 +0200
To: linux-kernel@vger.kernel.org
Subject: interrupt problem with MPS 1.4 / not with MPS 1.1 ?
Message-ID: <20010531203908.A23936@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware:

Abit VP6 (Via 694x) x86/SMP motherboard
with USB controller

If I set the bios for MPS 1.1, USB runs fine. If I set the bios
for MPS 1.4, I get this:

May 31 13:08:06 middle kernel: hub.c: USB new device connect on bus1/1, assigned device number 4
May 31 13:08:09 middle kernel: usb_control/bulk_msg: timeout
May 31 13:08:09 middle kernel: usb.c: USB device not accepting new address=4 (error=-110)
May 31 13:08:09 middle kernel: hub.c: USB new device connect on bus1/1, assigned device number 5
May 31 13:08:12 middle kernel: usb_control/bulk_msg: timeout
May 31 13:08:12 middle kernel: usb.c: USB device not accepting new address=5 (error=-110)
May 31 13:08:12 middle kernel: hub.c: USB new device connect on bus1/1, assigned device number 6
May 31 13:08:15 middle kernel: usb_control/bulk_msg: timeout
May 31 13:08:15 middle kernel: usb.c: USB device not accepting new address=6 (error=-110)
May 31 13:08:16 middle kernel: hub.c: USB new device connect on bus1/1, assigned device number 7
May 31 13:08:19 middle kernel: usb_control/bulk_msg: timeout
May 31 13:08:19 middle kernel: usb.c: USB device not accepting new address=7 (error=-110)
May 31 13:08:19 middle kernel: hub.c: USB new device connect on bus1/1, assigned device number 8
May 31 13:08:22 middle kernel: usb_control/bulk_msg: timeout
May 31 13:08:22 middle kernel: usb.c: USB device not accepting new address=8 (error=-110)
May 31 13:08:22 middle kernel: hub.c: USB new device connect on bus1/1, assigned device number 9

Now I understand this mail doesn't have all the necessary info, but my
question is:

What information would be necessary to debug this?

dmesg
/var/log/messages
lspci -vv (or -x?)

or more?

Jurriaan
-- 
BOFH excuse #57:

Groundskeepers stole the root password
GNU/Linux 2.4.5-ac4 SMP/ReiserFS 2x1402 bogomips load av: 0.41 0.11 0.03
