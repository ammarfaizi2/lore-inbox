Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318422AbSGYJaq>; Thu, 25 Jul 2002 05:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318423AbSGYJap>; Thu, 25 Jul 2002 05:30:45 -0400
Received: from 212.Red-80-35-44.pooles.rima-tde.net ([80.35.44.212]:11648 "EHLO
	DervishD.pleyades.net") by vger.kernel.org with ESMTP
	id <S318422AbSGYJap>; Thu, 25 Jul 2002 05:30:45 -0400
Date: Thu, 25 Jul 2002 11:41:03 +0200
Organization: Pleyades
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: USB problem with my printer
Message-ID: <3D3FC7AF.mail1CA1SQPD7@viadomus.com>
User-Agent: nail 9.31 6/18/02
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
From: DervishD <raul@pleyades.net>
Reply-To: DervishD <raul@pleyades.net>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all :))

    Shortly: the USB driver detects my printer and correctly
registers and unregisters it when disconnecting the USB cable. But
I'm not able to print thru USB port :((

    My printer is a Lexmark Optra E312, with parallel and USB ports.
I'm able to use it thru the parallel port without problems, but when
I use the USB interface, it doesn't work. I load modules 'usbcore',
'usb-uhci' and 'printer', I've created the node usblp0 (char, major
180, minor 0), but when I try to send something to the printer, using
'cat', 'echo' or even using 'pdq', the process goes to sleep forever
:( I've tested three different USB cables, and my USB port seems to
work.

    Am I doing something wrong? Do I need to pass args to the printer
USB driver?.

    Thanks in advance :)
    Raúl
