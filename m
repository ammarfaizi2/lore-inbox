Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266134AbTGIUxq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 16:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266141AbTGIUxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 16:53:46 -0400
Received: from sun13.bham.ac.uk ([147.188.128.145]:19128 "EHLO
	sun13.bham.ac.uk") by vger.kernel.org with ESMTP id S266134AbTGIUxo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 16:53:44 -0400
Subject: Oops 2.4.21-ac4 / pwc / usb-uhci / pwcx-i386 / nvidia
From: Mark Cooke <mpc@star.sr.bham.ac.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-9WS1TS9jleVlp5G/51Tk"
Organization: University Of Birmingham
Message-Id: <1057784902.3148.52.camel@pc24.sr.bham.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Jul 2003 22:08:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9WS1TS9jleVlp5G/51Tk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi all,

Just FYI really, as I had the nvidia driver plus the philips binary
compression support module loaded.

Camserv was running, and as the viewer broke off the connection, the
oops occurred.

Cheers,

Mark

-- 
Mark Cooke <mpc@star.sr.bham.ac.uk>
University Of Birmingham

--=-9WS1TS9jleVlp5G/51Tk
Content-Disposition: attachment; filename=oops
Content-Type: text/plain; name=oops; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Jul  9 20:59:28 pc24 kernel: usb-uhci.c: interrupt, status 3, frame# 1139
Jul  9 21:40:17 pc24 kernel: usb-uhci.c: interrupt, status 2, frame# 1374
Jul  9 21:40:17 pc24 kernel: hub.c: already running port 2 disabled by hub (EMI?), re-enabling...
Jul  9 21:40:17 pc24 kernel: usb.c: USB disconnect on device 00:1d.1-2 address 2
Jul  9 21:40:17 pc24 kernel: pwc Disconnected while device/video is open!
Jul  9 21:48:05 pc24 kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000048
Jul  9 21:48:05 pc24 kernel:  printing eip:
Jul  9 21:48:05 pc24 kernel: f8ac8402
Jul  9 21:48:05 pc24 kernel: *pde = 00000000
Jul  9 21:48:05 pc24 kernel: Oops: 0000
Jul  9 21:48:05 pc24 kernel: sg ppp_deflate zlib_deflate ppp_async ppp_generic slhc pl2303 usbserial nfs sd_mod scsi_mod agpgart nvidia binfmt_misc vmnet vmmon lp parport pwc videodev nfs
Jul  9 21:48:05 pc24 kernel: CPU:    0
Jul  9 21:48:05 pc24 kernel: EIP:    0010:[<f8ac8402>]    Tainted: PF
Jul  9 21:48:05 pc24 kernel: EFLAGS: 00010296
Jul  9 21:48:05 pc24 kernel:
Jul  9 21:48:05 pc24 kernel: EIP is at video_ioctl [videodev] 0x22 (2.4.21-21.ac4.mc1)
Jul  9 21:48:05 pc24 kernel: eax: 00000000   ebx: ffffffe7   ecx: 00000005   edx: 40047612
Jul  9 21:48:05 pc24 kernel: esi: 40047612   edi: f70688e0   ebp: 00000005   esp: f789bf88
Jul  9 21:48:05 pc24 kernel: ds: 0018   es: 0018   ss: 0018
Jul  9 21:48:05 pc24 kernel: Process camserv (pid: 1828, stackpage=f789b000)
Jul  9 21:48:05 pc24 kernel: Stack: 00000000 40047612 0805c64c c014e179 f75fa3e0 f70688e0 40047612 0805c64c
Jul  9 21:48:05 pc24 kernel:        00000000 00000000 f789a000 0805c490 404e2008 bfffc268 c0109017 00000005
Jul  9 21:48:05 pc24 kernel:        40047612 0805c64c 0805c490 404e2008 bfffc268 00000036 0000002b 0000002b
Jul  9 21:48:05 pc24 kernel: Call Trace:   [<c014e179>] sys_ioctl [kernel] 0xc9 (0xf789bf94))
Jul  9 21:48:05 pc24 kernel: [<c0109017>] system_call [kernel] 0x33 (0xf789bfc0))
Jul  9 21:48:05 pc24 kernel:
Jul  9 21:48:05 pc24 kernel:
Jul  9 21:48:05 pc24 kernel: Code: ff 50 48 89 c2 b8 ea ff ff ff 81 fa fd fd ff ff 0f 45 c2 83
Jul  9 21:48:05 pc24 kernel:  <7>pwc pwc_isoc_handler() called with status -84 [CRC/Timeout].

--=-9WS1TS9jleVlp5G/51Tk--

