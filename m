Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265531AbTGNL2q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 07:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbTGNL2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 07:28:46 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:35595 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S270096AbTGNL1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 07:27:18 -0400
From: "" <simon@baydel.com>
To: linux-kernel@vger.kernel.org
Date: Mon, 14 Jul 2003 12:27:37 +0100
MIME-Version: 1.0
Subject: PPC 440 System
Message-ID: <3F12A1B9.3086.614B56@localhost>
X-mailer: Pegasus Mail for Windows (v4.11)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an IBM ebony development board which has a PPC 440 
processor. I am trying to build a development system for it. It 
currently loads a cross compiled kernel and kicks out messages via 
the first serial port, no vga. It mounts the root fs via nfs and tries to 
exec /sbin/init. At this point the system appears to hang. 

If I remove /sbin/init from the nfs root the kernel panics as expected, 
so I assume root is mounted ok. I have tried to build a minimum root 
filesystem which contains /dev/console, /dev/ttyS0 and a statically 
linked /sbin/init. The init just does a printf but I do not see this 
message. Does anyone know it this should work ? 

Initially I tried to build a root filesystem from files on a Mac Clone 
running Yellow Dog Linux. I believe this has a PPC 604e processor. 
Should this systems binaries/libraries run on the 440GP ?

Can I expect a statically linked executable, made on the Mac, to run
on the 440GP?


Many Thanks

Simon. 
__________________________

Simon Haynes - Baydel 
Phone : 44 (0) 1372 378811
Email : simon@baydel.com
__________________________

