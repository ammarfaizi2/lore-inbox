Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279798AbRLQNUY>; Mon, 17 Dec 2001 08:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280027AbRLQNUN>; Mon, 17 Dec 2001 08:20:13 -0500
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:59144 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id <S279798AbRLQNUH>; Mon, 17 Dec 2001 08:20:07 -0500
From: "" <simon@baydel.com>
To: linux-kernel@vger.kernel.org
Date: Mon, 17 Dec 2001 09:57:03 -0000
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Panic output
Message-ID: <3C1DC16F.19499.A8A87F@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During writing a driver for a PCI board I experienced the hardware 
hanging and I had to press the big red button. The hang was traced 
using a PCI analyzer and I found that the driver, loaded as a 
module, was taking a route which called panic. I changed 
/proc/sys/kernel/panic to a non zero value and the machine started 
to reboot on PCI hang. My problem is I never see any output on the 
screen or in /var/log/messages. All the stuff I have looked at in 
/usr/src/linux/Documentation suggests the messages should be 
here. I am running a 2.4.0 kernel with a SuSE 7.1 installation. At 
the hang time the system is running kde 2 and in a command 
winow I have a tail -f /var/log/messages running. The first change I 
see is the PC bios startup. 

Please Help

Simon.
__________________________

Simon Haynes - Baydel 
Phone : 44 (0) 1372 378811
Email : simon@baydel.com
__________________________
