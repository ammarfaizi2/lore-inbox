Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263203AbTI2MAU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 08:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263204AbTI2MAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 08:00:19 -0400
Received: from pop.gmx.net ([213.165.64.20]:11722 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263203AbTI2MAQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 08:00:16 -0400
X-Authenticated: #11949556
From: Michael Schierl <schierlm-usenet@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6.0-test4,5,6] [APM] when do you expect to get APM working again?
Date: Mon, 29 Sep 2003 13:59:05 +0200
Reply-To: schierlm@gmx.de
X-Mailer: Forte Agent 1.93/32.576 English (American)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Message-Id: <S263203AbTI2MAQ/20030929120016Z+1564@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i'm using an Acer Travelmate 210 TEV notebook. (Celeron 700).

I don't use any acpi, swsuspend, suspend-to-disk, only apm. (ACPI did
not work in test3, and since then I did not change anything on my
config, always did just 'make oldconfig'.

with kernels test1 to test3 i could say 'apm -s' to go to standby mode
and the computer woke up properly afterwards (with 2.4.20 kernel it
went down "properly" but crashed when it should wake up again).

Now, since test4 (up to test6) when i do an 'apm -s', i see messages
about the cdrom and the hd going down (i hear the hd going down as
well), but then neither the screen blanks nor the "Zzz" LED
(displaying that the notebook is in standby mode) goes on. I cannot do
anything then except pressing the power button long then - no way to
wake it up any more.

I read something about test4's power management totally f*cked up on
test4, so I did not "complain" then, but waited a bit first.

is that problem known? Should I try any patches?

TIA,

Michael
-- 
"New" PGP Key! User ID: Michael Schierl <schierlm@gmx.de>
Key ID: 0x58B48CDD    Size: 2048    Created: 26.03.2002
Fingerprint:  68CE B807 E315 D14B  7461 5539 C90F 7CC8
http://home.arcor.de/mschierlm/mschierlm.asc
