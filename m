Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264456AbTDYVCz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 17:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263997AbTDYVCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 17:02:11 -0400
Received: from 015.atlasinternet.net ([212.9.93.15]:48356 "EHLO
	antoli.gallimedina.net") by vger.kernel.org with ESMTP
	id S264309AbTDYVCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 17:02:03 -0400
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: linux-kernel@vger.kernel.org
Subject: BUG: 2.5.68 uhci: host controlled halted and then kills the kernel
Date: Fri, 25 Apr 2003 23:14:13 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304252314.13085.gallir@uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, again me :-(

Playing aroung with the mouse, I've got the following error:

usb 1-1: USB disconnect, address 2
drivers/usb/host/uhci-hcd.c: 8800: host controller halted. very bad
                                                           ^^^^^^^^
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
...


The USB didn't wok anymore, then I stopped hotplug and the system died 
just after the message "Stopping hotplug subsystem" appeared in the 
konsole.

It's the same Dell Latitude X200.

BTW, the usb mouse doesn't work with ohci, altough the modules are loaded.

Also, the previously reported "psmouse.c: Lost synchronization" errors 
disappear by using /dev/input/mouse[01] instead of /dev/psaux and 
/dev/input/mice.



-- 
  ricardo galli       GPG id C8114D34
