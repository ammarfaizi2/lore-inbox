Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317851AbSHDOvp>; Sun, 4 Aug 2002 10:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317858AbSHDOvp>; Sun, 4 Aug 2002 10:51:45 -0400
Received: from dsl-213-023-061-042.arcor-ip.net ([213.23.61.42]:31759 "EHLO
	spot.local") by vger.kernel.org with ESMTP id <S317851AbSHDOvp>;
	Sun, 4 Aug 2002 10:51:45 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Oliver Feiler <kiza@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19, USB_HID only works compiled in, not as module
Date: Sun, 4 Aug 2002 16:56:19 +0200
User-Agent: KMail/1.4.1
X-PGP-KeyID: 0x561D4FD2
X-PGP-Key: http://www.lionking.org/~kiza/pgpkey.shtml
X-Species: Snow Leopard
X-Operating-System: Linux i686
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200208041656.21035.kiza@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since 2.4.19 a usb mouse does not work anymore if

CONFIG_USB_HID=m
and
CONFIG_INPUT_MOUSEDEV=m

is set. It only works if both are compiled into the kernel. Yes, I have set
CONFIG_USB_HIDINPUT=y.

I've also seen other complaints about usb mice not working in 2.4.19, I guess 
that's the problem?

If the stuff is compiled as modules, everything seems to be fine. The kernel 
messages are the same, everything is detected fine. Except that 'cat 
/dev/input/mice' does not give any output if the driver is compiled as 
module.

Cheers,
Oliver

-- 
Oliver Feiler  <kiza@(gmx(pro).net|lionking.org|claws-and-paws.com)>
http://www.lionking.org/~kiza/  <--   homepage
PGP-key ID 0x561D4FD2    --> /pgpkey.shtml
http://www.lionking.org/~kiza/journal/

