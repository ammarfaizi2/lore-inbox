Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313867AbSERU5N>; Sat, 18 May 2002 16:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313925AbSERU5N>; Sat, 18 May 2002 16:57:13 -0400
Received: from ucsu.Colorado.EDU ([128.138.129.83]:1238 "EHLO
	ucsu.colorado.edu") by vger.kernel.org with ESMTP
	id <S313867AbSERU5M>; Sat, 18 May 2002 16:57:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ivan Gyurdiev <ivangurdiev@linuxfreemail.com>
Reply-To: ivangurdiev@linuxfreemail.com
Organization: ( )
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.5.16 Keyboard bug
Date: Sat, 18 May 2002 08:51:32 -0600
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <02051808513200.01086@cobra.linux>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

...is still there.
Sure, acpi=off "fixes" it, but that's not really a fix.

Question...is this an acpi bug or a keyboard bug?
Is there an existing patch to correct this that hasn't been merged into the 
kernel yet?

[root@cobra log]# grep "AT keyboard" messages
May 14 17:58:57 cobra kernel: keyboard: Timeout - AT keyboard not present?(ed)
May 14 17:59:00 cobra kernel: keyboard: Timeout - AT keyboard not present?(f4)
May 14 18:26:56 cobra kernel: keyboard: Timeout - AT keyboard not present?(ed)
May 14 18:26:59 cobra kernel: keyboard: Timeout - AT keyboard not present?(f4)
.......

etc

Mouse is fine until keyboard input freezes everything.

