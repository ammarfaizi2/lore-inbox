Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261545AbTCKTRD>; Tue, 11 Mar 2003 14:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261546AbTCKTRC>; Tue, 11 Mar 2003 14:17:02 -0500
Received: from chaos.analogic.com ([204.178.40.224]:59267 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261545AbTCKTQF>; Tue, 11 Mar 2003 14:16:05 -0500
Date: Tue, 11 Mar 2003 14:29:39 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Firewire on Linux-2.4.20
Message-ID: <Pine.LNX.3.95.1030311142745.2204A-100000@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello FIREWIRE gurus!

I am trying to get Linux-2.4.20 running!  I need the
IEEE1394 PCILYNX module working. The configuration has
strangely changed since linux-2.4.18 so the required
object file becomes an 8-byte text file!

Script started on Tue Mar 11 14:15:40 2003
# pwd
/usr/src/linux-2.4.20/drivers/ieee1394
# ls -la pcilynx.o
-rw-r--r--   1 root     root            8 Mar 11 14:12 pcilynx.o
# cat pcilynx.o
!<arch>
# exit
exit

Script done on Tue Mar 11 14:16:15 2003

I haven't a clue how to fix this. Does anybody know?
Here is the relevant parts of ".config" 

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
CONFIG_IEEE1394=m

#
# Device Drivers
#
CONFIG_IEEE1394_PCILYNX=m
CONFIG_IEEE1394_PCILYNX_LOCALRAM=y
CONFIG_IEEE1394_PCILYNX_PORTS=y
CONFIG_IEEE1394_OHCI1394=m

#
# Protocol Drivers
#
# CONFIG_IEEE1394_VIDEO1394 is not set
CONFIG_IEEE1394_SBP2=m
CONFIG_IEEE1394_RAWIO=m
# CONFIG_IEEE1394_VERBOSEDEBUG is not set

#
# I2O device support
#
CONFIG_I2O=m
CONFIG_I2O_PCI=m
CONFIG_I2O_BLOCK=m
CONFIG_I2O_LAN=m
CONFIG_I2O_SCSI=m
CONFIG_I2O_PROC=m

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


