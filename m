Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271124AbTHCHeC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 03:34:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271125AbTHCHeB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 03:34:01 -0400
Received: from mailout.mbnet.fi ([194.100.161.24]:40203 "EHLO posti.mbnet.fi")
	by vger.kernel.org with ESMTP id S271124AbTHCHdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 03:33:45 -0400
Message-ID: <1373.194.100.227.79.1059896027.squirrel@webmail.mbnet.fi>
Date: Sun, 3 Aug 2003 10:33:47 +0300 (EEST)
Subject: 2.6.0-test2-bk2 usb hid problems
From: Joonas Koivunen <rzei@mbnet.fi>
To: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.5)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-OriginalArrivalTime: 03 Aug 2003 07:33:43.0873 (UTC) FILETIME=[91431B10:01C35991]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Having tried many houres to get usb module loading working with the
current latest linux version I hate to say I haven't been able to make
any progress.

I do have the latest module-init-tools plus all the other requirements
in Documentation/Changes are passed.

I first configured the kernel to have CONFIG_MOUSEDEV as module, uhci-
hcd as builtin and hid related as modules. Ok so far. I also have other
modules for example netfilter and nic drivers.

Rebooted to the new kernel, it starts nicely but /dev/input/mouse0
(13:32 if i remember correctly) doesn't exist. So I try to load
appropiate drivers in /lib/modules/.../kernel/drivers/usb/*/*. For each
module the latest and the 0.9.12 version of module-init-tools tells
me "FATAL: $modulename not found". insmod doesn't recognize the module
format, tells something like "Insertion failed" plus -1 as error code
(not as the exit code).

For all other modules modprobe + insmod work file. modinfo works for
those usb modules and all others too.

Hope this helps.. Could you please include me in CC or BCC as i can't
be on the list because of missing email client (have to use crappy
webmail).

-rzei


