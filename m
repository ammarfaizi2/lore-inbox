Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750902AbWFZLal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbWFZLal (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 07:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbWFZLal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 07:30:41 -0400
Received: from bambus1.net.skarpam.net ([83.142.194.78]:59817 "EHLO
	orbiter.attika.ath.cx") by vger.kernel.org with ESMTP
	id S1750902AbWFZLak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 07:30:40 -0400
Date: Mon, 26 Jun 2006 13:30:38 +0200
From: Piotr Kaczuba <pepe@attika.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: [x86-64] ioctl32 for USB
Message-ID: <20060626113037.GA6265@attika.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I'm running a 64-bit kernel and 32-bit userspace. There seems to be some
unimplemented compability ioctls regarding USB. Dmesg shows the
following:

[184966.543022] ioctl32(hald-probe-hidd:10760): Unknown cmd fd(4)
cmd(81004806){01} arg(ffb52dd0) on /dev/usb/hiddev0

and

[50974.410204] ioctl32(vmware-vmx:3470): Unknown cmd fd(140)
cmd(40109980){00} arg(ffb551a0) on /proc/bus/usb/002/001

Have it been only forgotten or are there other more serious reasons that
these ioctls are missing?

Piotr Kaczuba
