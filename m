Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262990AbSJBHrA>; Wed, 2 Oct 2002 03:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262992AbSJBHrA>; Wed, 2 Oct 2002 03:47:00 -0400
Received: from mail.set-software.de ([193.218.212.121]:62086 "EHLO
	gateway.local.net") by vger.kernel.org with ESMTP
	id <S262990AbSJBHq6> convert rfc822-to-8bit; Wed, 2 Oct 2002 03:46:58 -0400
From: Michael Knigge <Michael.Knigge@set-software.de>
Date: Wed, 02 Oct 2002 07:53:40 GMT
Message-ID: <20021002.7534009@knigge.local.net>
Subject: make menuconfig
To: linux-kernel@vger.kernel.org
X-Mailer: Mozilla/3.0 (compatible; StarOffice/5.1; Win32)
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get this little error message if I isse a "make menuconfig"

crash:/usr/src/linux-2.5.40# make menuconfig
make[1]: Entering directory `/usr/src/linux-2.5.40/scripts'
make -C lxdialog all
make[2]: Entering directory `/usr/src/linux-2.5.40/scripts/lxdialog'
make[2]: Leaving directory `/usr/src/linux-2.5.40/scripts/lxdialog'
make[1]: Leaving directory `/usr/src/linux-2.5.40/scripts'
/bin/sh ./scripts/Menuconfig arch/i386/config.in
Using defaults found in .config
Preparing scripts: functions, 
parsing..............................................................
............/scripts/Menuconfig: ./MCmenu74: line 56: syntax error 
near unexpected token `fi'
./scripts/Menuconfig: ./MCmenu74: line 56: `fi'
...............done.

Saving your kernel configuration...

*** End of Linux kernel configuration.
*** Check the top-level Makefile for additional configuration.
*** Next, you may run 'make bzImage', 'make bzdisk', or 'make 
install'.

Bye
  MK




