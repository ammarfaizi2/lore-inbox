Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264605AbTLMNNo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 08:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264981AbTLMNNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 08:13:44 -0500
Received: from pop.gmx.net ([213.165.64.20]:23484 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264605AbTLMNNn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 08:13:43 -0500
X-Authenticated: #598989
From: Timo Maier <tam@gmx.de>
Organization: Freiburg / Germany
To: linux-kernel@vger.kernel.org
Subject: Can't access HPFS with Kernel 2.6
Date: Sat, 13 Dec 2003 14:13:26 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200312131413.26577.tam@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

With Kernel 2.4 it was no problem reading my HPFS partition. Since I 
switched to 2.6 it's no longer possible to access it. A kernel-bug 
message pops up in fullscreen window. Currently I use test11 kernel, 
but it was all the same with older 2.6 kernels.

Here's some more information:

Machine is a Thinkpad T23

kernel bug at include/linux/smp_lock.h:53!
invalid operand: 000 [#1]
CPU: 0
EIP: 0060:[<c01f0a15>] Not tainted
EFLAGS: 00010286
(hier viele Zahlen, die ich nicht abtippen will)
dann zum Schluss
Speicherzugriffsfehler


Die HPFS Partition wird automatisch beim Booten gemounted.

hier aus /etc/fstab
/dev/hda3 /mnt/os2 hpfs ro,users,umask=000 0 0

hpfs Treiber ist fest in dern kernel compiliert, wenn ich mit einem 
2.4er Kernel boote klappt alle einwandfrei.

-- 
Timo

