Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130180AbQKTTXR>; Mon, 20 Nov 2000 14:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130187AbQKTTXH>; Mon, 20 Nov 2000 14:23:07 -0500
Received: from www23.gmx.net ([213.165.64.73]:50304 "HELO www23.gmx.net")
	by vger.kernel.org with SMTP id <S130180AbQKTTWw>;
	Mon, 20 Nov 2000 14:22:52 -0500
Date: Mon, 20 Nov 2000 19:52:47 +0100 (MET)
From: karl.gustav@gmx.net
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0001826769@gmx.net
X-Authenticated-IP: [194.138.37.36]
Message-ID: <9838.974746367@www23.gmx.net>
X-Mailer: WWW-Mail 1.5 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've a Wacom Graphire USB. I tested the test11-pre6 kernel with my
Graphire USB. The scroll whell of the Graphire mouse does not work with the last
test kernels. The last kernel supporting the wheel was test11-pre2, I think...
                 
I used the IMPS/2 compatible mouse emulation of the wacom driver
(/dev/input/mice).

Otherwise I have a general USB problem with my SMP box. Under heavy load
the Graphire stops working and the USB is dead. Unload and reload of the USB
modules does not help. No interrupts are registered anymore. I tested with  
usb-uhci and uhci, too. The same result.

Is it possible, that there are some interrupts eaten under high load and
the
kernel (or USB driver) does not handle this correctly? With older kernels
I had promblems with APIC errors and one of the CPUs stoped working and some
seconds or minutes later the whole system was frozen. But this problems
have gone with the latest kernels. The USB problem seems to be the last one of
this kind (for me).

    Karl

PS: Is there an OHCI compliant PCI USB controller card available? I'm
    using an UHCI type with a VIA chip.

-- 
Sent through GMX FreeMail - http://www.gmx.net

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
