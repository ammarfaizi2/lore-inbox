Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318249AbSHSJIv>; Mon, 19 Aug 2002 05:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318250AbSHSJIv>; Mon, 19 Aug 2002 05:08:51 -0400
Received: from 5.Red-80-32-157.pooles.rima-tde.net ([80.32.157.5]:43280 "EHLO
	smtp.newipnet.com") by vger.kernel.org with ESMTP
	id <S318249AbSHSJIo> convert rfc822-to-8bit; Mon, 19 Aug 2002 05:08:44 -0400
Message-ID: <200208191110450791.0D42F6D9@192.168.128.16>
References: <200208191108120240.0D409F0A@192.168.128.16>
X-Mailer: Calypso Version 3.30.00.00 (4)
Date: Mon, 19 Aug 2002 11:10:45 +0200
From: "Carlos Velasco" <carlosev@newipnet.com>
To: linux-kernel@vger.kernel.org
Subject: Serial Console
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have configured kernel to do output to tty0 and ttyS0 (serial console).

LILO:
image = /boot/vmlinuz_2419
  root = /dev/hda3
  label = linux_2419
  append="console=ttyS0,115200n8r console=tty0 vga=0x0301"


However I have seen that if I don't open the serial port from another machine, I can't reboot or boot kernel, as the output seems to freeze until port is open. When I open the serial port, normal operation is resumed.
Is there something to solve this issue?
I would like to use the serial console only when needed not always that I want boot or reboot machine.

Regards,
Carlos Velasco


