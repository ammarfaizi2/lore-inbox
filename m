Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131990AbQKJX6S>; Fri, 10 Nov 2000 18:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131750AbQKJX6J>; Fri, 10 Nov 2000 18:58:09 -0500
Received: from pop.gmx.net ([194.221.183.20]:874 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S129944AbQKJX5v>;
	Fri, 10 Nov 2000 18:57:51 -0500
From: Gerald Haese <Gerald.Haese@gmx.de>
Reply-To: Gerald.Haese@gmx.de
Organization: GMX
Date: Sat, 11 Nov 2000 01:01:20 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Subject: USB mouse stops working
MIME-Version: 1.0
Message-Id: <00111101012003.01860@dose>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, ...

the following problem is not a new one (for me):

I'm using an SMP system. Everything works fine and (absolutely) stable - 
exept my USB mouse :-( It's the USB version of the Wacom Graphire tablet. The 
mouse works great for some minutes or up to half an hour and it generates a 
lot of interrupts during this time ... And now the mouse stops working. No 
interrupt is generated. The USB printer does not work any more. Unloading and 
reloading of the USB related modules does not help :-( No interrupts are 
registered for USB (seen in /proc/interrupts).

I think it's not a problem of the wacom driver only, the USB is compleatly 
blocked. In the past I had a lot of SMP related interrupt problems in other 
kernel modules (e.g in the hisax). But this problems have gone away during 
the last kernel releases. The USB problem is the last one for me in the 2.4 
kernel ... :-)

Gerald

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
