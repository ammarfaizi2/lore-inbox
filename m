Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266897AbUBEVoj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 16:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266814AbUBEVmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 16:42:12 -0500
Received: from needs-no.brain.uni-freiburg.de ([132.230.63.23]:29004 "EHLO
	needs-no.brain.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S266785AbUBEVj7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 16:39:59 -0500
Date: Thu, 5 Feb 2004 22:39:53 +0100 (MET)
From: Thomas Voegtle <thomas@voegtle-clan.de>
To: linux-kernel@vger.kernel.org
Subject: sudden reboot with using mtrr
Message-ID: <Pine.LNX.4.21.0402052234390.20340-100000@needs-no.brain.uni-freiburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

with 2.6.2 and earlier I get sooner or later a sudden soft reset when I
use my graphic card with games or for example using uae (the amiga
emulator).

It takes different time until the hard reset happens, but with 
mtrr/agpgart/DRI switched on it definitely happens.

And sometimes I see this:
mtrr: base(0xdc000000) is not aligned on a size(0x1800000) boundary
or this:
mtrr: 0xdc000000,0x2000000 overlaps existing 0xdd000000,0x800000


Peaceful gaming with 2.4.x or 2.6.x with mtrr switched off.

SuSE 9.0
Matrox Graphics, Inc. MGA G400 AGP

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Celeron (Coppermine)
stepping        : 6
cpu MHz         : 851.910

Chipset:
VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev c4)
VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]

I do not know how to get more information, there is no output on serial,
it just reboots suddenly.

please cc me, I'm not subscribed

Greetings,
Thomas


-- 
 Thomas Vögtle    email: thomas@voegtle-clan.de
 ----- http://www.voegtle-clan.de/thomas ------


