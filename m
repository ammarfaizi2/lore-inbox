Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265390AbUGDFJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265390AbUGDFJt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 01:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265395AbUGDFJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 01:09:49 -0400
Received: from tag.witbe.net ([81.88.96.48]:18614 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S265390AbUGDFJr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 01:09:47 -0400
Message-Id: <200407040509.i6459iX21158@tag.witbe.net>
Reply-To: <rol@as2917.net>
From: "Paul Rolland" <rol@as2917.net>
To: <linux-kernel@vger.kernel.org>
Subject: Init single and Serial console : How to ?
Date: Sun, 4 Jul 2004 07:09:39 +0200
Organization: AS2917
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcRhhRs+yLX89HmXS5qQTBX2wOM0bQ==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm trying to activate a serial console on a Linux 2.4.20 (OK, this is not
the
most recent one, but this is the one I'm running).

Configuration is quite simple : at the LILO prompt, I key in :
LILO: linux console=ttyS0 -s

This is supposed to start Linux, and have the console on ttyS0.

The problem is that the bash prompt ends on the monitor, not on the serial
port.

I've read about the :

    ioctlsave is a small utility to create the Linux SysV init file
    /etc/ioctl.save from a multiple user run level rather than from single
    user mode. /etc/ioctl.save contains the terminal settings to be used in
    single user mode. Users of terminals or modems which cannot be
    configured to operate at 9600bps (and thus set ioctl.save using the
    standard mechanism) will find this utility useful. 

but,  the problem is that this operation is only possible if you can have
access to the machine (to run the ioctlsave utility).

When you have a remote machine, for which you have a serial access at boot 
time, but which is not completed its "go to runlevel 3" boot to give you
a serial console, how is it possible to force it to give you a prompt on
the serial port in single mode ?

Regards,
Paul

