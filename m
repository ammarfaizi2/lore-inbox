Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263319AbTJZRA1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 12:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263328AbTJZRA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 12:00:27 -0500
Received: from nameserver1.brainwerkz.net ([209.251.159.130]:39301 "EHLO
	nameserver1.mcve.com") by vger.kernel.org with ESMTP
	id S263319AbTJZRAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 12:00:25 -0500
Message-ID: <32985.68.105.173.45.1067188279.squirrel@mail.mainstreetsoftworks.com>
Date: Sun, 26 Oct 2003 12:11:19 -0500 (EST)
Subject: Realtek 8169 - 8110S driver patch
From: "Brad House" <brad_mssw@gentoo.org>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The RealTek 8110S chip is distributed on many x86_64 mobos,
and the current in-kernel version of the r8169 driver does
not appear to work.  I have adapted this driver from the
official realtek 2.4 driver at:
ftp://210.51.181.211/cn/nic/rtl8169rtl8169sbrtl8110sb/linux2.4.x-8169s(160)0915.zip

The patch for the 2.6 kernel is located here:
http://dev.gentoo.org/~brad_mssw/kernel_patches/2.6.0/2.6.0-test9-r8169-8110S.patch

This has been tested extensively on x86_64. The only quirk
found is that it seems to require ACPI to work, but it seems
as though x86_64 has this requirement all-around to be
fully-functional.

Please CC me on any replies!

-Brad House
brad_mssw@gentoo.org
Gentoo Linux




