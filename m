Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265320AbUBFNVS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 08:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265442AbUBFNVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 08:21:18 -0500
Received: from smtp.freestart.hu ([213.197.64.6]:48908 "EHLO
	relay.freestart.hu") by vger.kernel.org with ESMTP id S265320AbUBFNVO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 08:21:14 -0500
Date: Fri, 6 Feb 2004 13:53:40 +0100 (CET)
From: "Peter S. Mazinger" <ps.m@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: BUG in 2.4.25-rc1: attempt to access beyond end of device
Message-ID: <Pine.LNX.4.44.0402061347160.27376-100000@lnx.bridge.intra>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-freestart-banner: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

my hardware:
x86
ide controller (builtin driver)
ext3 partitions (as modules loaded from initrd)

if I shutdown -h now the computer, I get as last messages:
attempt to access beyond end of device
03:03 rw=0, want=1044228, limit=1044225
(3 times, 03:03/want/limit with other numbers), for all mounted
(remounted ro) partitions

distro: RedHat 7.3 (with all updates up to december)
kernel is pristine: only 2.4.25-rc1 applied (EXPERIMENTAL code disabled)
util-linux: 2.11n-12.7.3 (used umount, if it matters)

Peter

-- 
Peter S. Mazinger <ps dot m at gmx dot net>           ID: 0xA5F059F2
Key fingerprint = 92A4 31E1 56BC 3D5A 2D08  BB6E C389 975E A5F0 59F2


____________________________________________________________________
Miert fizetsz az internetert? Korlatlan, ingyenes internet hozzaferes a FreeStarttol.
Probald ki most! http://www.freestart.hu
