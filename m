Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266914AbRGXEic>; Tue, 24 Jul 2001 00:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266929AbRGXEiV>; Tue, 24 Jul 2001 00:38:21 -0400
Received: from rj.sgi.com ([204.94.215.100]:3731 "EHLO rj.corp.sgi.com")
	by vger.kernel.org with ESMTP id <S266914AbRGXEiQ>;
	Tue, 24 Jul 2001 00:38:16 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: pyrenees@club-internet.fr
cc: linux-kernel@vger.kernel.org
Subject: Re: The moxa.c module is not compiled in 2.4.7 kernel. 
In-Reply-To: Your message of "Mon, 23 Jul 2001 23:49:17 +0200."
             <01072323491700.00616@linux> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 24 Jul 2001 14:38:11 +1000
Message-ID: <23760.995949491@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 23 Jul 2001 23:49:17 +0200, 
"J.L.Carlet" <pyrenees@club-internet.fr> wrote:
>I have a problem with the 2.4.7 kernel only, not with the 2.4.6.
>In the 2.4.6, using make xconfig, I select Moxa Intellio support, in the 
>Character devices menu. I made make dep, make clean, make modules, make 
>modules_install, and then I obtained the moxa.o file in 
>/lib/modules/2.4.6/kernel/drivers/char directory.
>If I make the same operations with 2.4.7 kernel, I don't obtain moxa.o
>The file is not compiled and not installed.

It compiles and installs for me on 2.4.7, using make xconfig.

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
# CONFIG_SERIAL_CONSOLE is not set
CONFIG_SERIAL_EXTENDED=y
# CONFIG_SERIAL_MANY_PORTS is not set
# CONFIG_SERIAL_SHARE_IRQ is not set
# CONFIG_SERIAL_DETECT_IRQ is not set
# CONFIG_SERIAL_MULTIPORT is not set
# CONFIG_HUB6 is not set
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_COMPUTONE is not set
# CONFIG_ROCKETPORT is not set
# CONFIG_CYCLADES is not set
# CONFIG_DIGIEPCA is not set
# CONFIG_DIGI is not set
# CONFIG_ESPSERIAL is not set
CONFIG_MOXA_INTELLIO=m
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_ISI is not set
# CONFIG_SYNCLINK is not set
# CONFIG_N_HDLC is not set
# CONFIG_RISCOM8 is not set
# CONFIG_SPECIALIX is not set
# CONFIG_SX is not set
# CONFIG_RIO is not set
# CONFIG_STALDRV is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

