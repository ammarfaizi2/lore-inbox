Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262024AbSJEMJR>; Sat, 5 Oct 2002 08:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262025AbSJEMJQ>; Sat, 5 Oct 2002 08:09:16 -0400
Received: from transport.cksoft.de ([62.111.66.27]:44552 "EHLO
	transport.cksoft.de") by vger.kernel.org with ESMTP
	id <S262024AbSJEMIV>; Sat, 5 Oct 2002 08:08:21 -0400
Date: Sat, 5 Oct 2002 12:08:56 +0000 (UTC)
From: "Bjoern A. Zeeb" <bzeeb-lists@lists.zabbadoz.net>
X-X-Sender: bz@e0-0.zab2.int.zabbadoz.net
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: serial cons prob on reboot in 2.5
Message-ID: <Pine.BSF.4.44.0210051202450.39858-100000@e0-0.zab2.int.zabbadoz.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

when rebooting a 2.5 machine I only get crap on the serial console
and nothing readable. Works fine while booting and running.

Anybody any ideas ? I there anything I can do / check ?


#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
# CONFIG_SERIAL_8250_CS is not set
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_MANY_PORTS is not set
# CONFIG_SERIAL_8250_SHARE_IRQ is not set
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
# CONFIG_SERIAL_8250_MULTIPORT is not set
# CONFIG_SERIAL_8250_RSA is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y


Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled

-- 
Greetings

Bjoern A. Zeeb				bzeeb at Zabbadoz dot NeT
56 69 73 69 74				http://www.zabbadoz.net/

