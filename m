Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbWEVDuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWEVDuv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 23:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWEVDuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 23:50:51 -0400
Received: from vbn.0050556.lodgenet.net ([216.142.194.234]:44749 "EHLO
	vbn.0050556.lodgenet.net") by vger.kernel.org with ESMTP
	id S1751166AbWEVDuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 23:50:51 -0400
Subject: Re: [LINUX-KERNEL] Problem loading any custom driver
From: Arjan van de Ven <arjan@infradead.org>
To: "Libershteyn, Vladimir" <vladimir.libershteyn@hp.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1FB1F81B4767FC48A2AF2278D735CE64038BFC5C@cacexc05.americas.cpqcorp.net>
References: <1FB1F81B4767FC48A2AF2278D735CE64038BFC5C@cacexc05.americas.cpqcorp.net>
Content-Type: text/plain
Date: Mon, 22 May 2006 05:50:47 +0200
Message-Id: <1148269847.3902.57.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-05-21 at 20:42 -0700, Libershteyn, Vladimir wrote:
> Greetings,
> 
> I need a help on understanding and possible resolution on a problem I have while trying to load driver(s) to a server running Linux_IA32_RH_EL4_Update3 either AS or WS
> I have a few (actually four) device drivers for different type of devices.
> These drivers compile and run fine on any 2.4.x kernels for both desktops/workstations and servers.
> The same drivers run fine on desktops/workstations and on slected servers, like IA64 Itanium servers, AMD64 servers, however I can't make it run on IA32 servers.
> I've noticed one common among all IA32 servers drivers won't run. All of them have dual processors motherboard with only one processor installed.
> The actual problem is: the first kernel function call from the driver (I'm running "insmod drivername" that calls driver_init function) cause kernel to panic.
> I believe the problem is either with kernel configuration/setup or with development environment configuration/setup.
> Any help/ideas are greatly appretiated. Below are part of a source code and related part of /var/log/messages. Please let me know if more information needed
> 
> Regards,

you forgot to put a URL to your source code.......

however it strongly points towards a broken Makefile on your side.... if
we'd have that URL I could say for sure ..


