Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261549AbVDJSdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbVDJSdT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 14:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbVDJSaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 14:30:08 -0400
Received: from mail.aknet.ru ([217.67.122.194]:15622 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261555AbVDJS3V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 14:29:21 -0400
Message-ID: <42597088.9050004@aknet.ru>
Date: Sun, 10 Apr 2005 22:29:28 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: formatting CD-RW locks the system
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I am trying to format the CD-RW disc
on my NEC ND-3520A DVD writer, and the
results are completely unexpected: I do
cdrwtool -d /dev/cdrom -q
It proceeds with the formatting, but
while it does so, the system is pretty
much dead. It can do some trivial tasks
like the console switching, but as soon
as it comes to any disc I/O, the processes
are hanging. After the formatting is done,
the system is back alive. That reminds me
formatting the floppies under DOS in those
ancient times, with the only difference
that formatting a floppy takes ~2 minutes,
while formatting a CD-RW takes ~20 minutes,
which is not good at all.
Is this something known or a bug?
I tried that on a 2.6.11-rc3-mm2 and
on a 2.6.12-rc1 kernels.

Also, is there any way to use the
packet writing with the CD-R/DVD-R discs,
or is it supposed to work only with the
-RW discs?

