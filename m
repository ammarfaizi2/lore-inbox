Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265424AbTFZIo3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 04:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265435AbTFZIo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 04:44:29 -0400
Received: from [62.12.131.37] ([62.12.131.37]:29085 "HELO debian")
	by vger.kernel.org with SMTP id S265424AbTFZIo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 04:44:28 -0400
Date: Thu, 26 Jun 2003 10:58:17 +0200
From: "Zeno R.R. Davatz" <zdavatz@ywesee.com>
To: linux-kernel@vger.kernel.org
Subject: INIT:ld"2" respawning too fast:disabled for 5 minutes
Message-Id: <20030626105817.17c1323c.zdavatz@ywesee.com>
Organization: ywesee - intellectual capital connected
X-Mailer: Sylpheed version 0.9.0claws (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi List

I succeded twice in making a kernel_image with the Debian kernel-package and installaing the .deb file (2.4.18, 2.4.20).

My Installation where I boot from is bf24-2.4.20 (floppies).

I download the kernel sources to /usr/src/linux-2.4.21 I do make clean, make menuconfig and then make-kpkg -rev ywesee.1 kernel_image. 

The maschine ends the compilation just fine and I do dpkg -i kernel_image-2.4.21-ywesee.1-i386.deb.

Then I reboot, everythings starts fine _without a kernel panic.

But: After starting the cron daemon I get:
INIT:ld"2" respawning too fast:disabled for 5 minutes 

I get this several times...

Why do I get this message and how can I get rid of it so my 2.4.21 boots nicely.

(I need to start my installation again from the beginning as I can not boot into the old system).

Many thanks in advance for any help and hints.

Zeno
