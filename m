Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263587AbUAEKGt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 05:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263609AbUAEKGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 05:06:48 -0500
Received: from AGrenoble-101-1-5-227.w80-11.abo.wanadoo.fr ([80.11.136.227]:60877
	"EHLO awak.dyndns.org") by vger.kernel.org with ESMTP
	id S263587AbUAEKGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 05:06:47 -0500
Subject: 2.6.0 under vmware ?
From: Xavier Bestel <xavier.bestel@free.fr>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1073297203.12550.30.camel@bip.parateam.prv>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 05 Jan 2004 11:06:43 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have problems running 2.6.0 under vmware (4.02 and 4.05). I did a
basic debian/sid install, then installed various 2.6.0 kernel images
(with or without initrd, from debian (-test9 and -test11) or self-made
(stock 2.6.0).
They all make /sbin/init (from sysvinit 2.85) segfault at a particular
address (I haven't yet recompiled it with -g to see where, but a
dissassembly shows it's a "ret").
I try booting to /bin/sh from the initrd, and there I can play with the
shell, mount the alternate root, play with commands there, and then exec
/sbin/init, but it segfaults at the same point.

Has anyone managed to make a basic debian with 2.6 work under vmware ?
Has anyone managed to make another distro with 2.6 work under vmware ?

Thanks, and happy new year to everyone,

	Xav

