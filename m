Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261882AbVAaBEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbVAaBEb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 20:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbVAaBEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 20:04:31 -0500
Received: from topsns.toshiba-tops.co.jp ([202.230.225.5]:52228 "HELO
	topsns.toshiba-tops.co.jp") by vger.kernel.org with SMTP
	id S261882AbVAaBE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 20:04:29 -0500
Date: Mon, 31 Jan 2005 10:04:21 +0900 (JST)
Message-Id: <20050131.100421.93019706.nemoto@toshiba-tops.co.jp>
To: ralf@linux-mips.org
Cc: arnd@arndb.de, akpm@osdl.org, linux-kernel@vger.kernel.org, bunk@stusta.de
Subject: Re: [PATCH] Fix SERIAL_TXX9 dependencies
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20050130165839.GB27703@linux-mips.org>
References: <20050130.220537.45151614.anemo@mba.ocn.ne.jp>
	<200501301645.14069.arnd@arndb.de>
	<20050130165839.GB27703@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sun, 30 Jan 2005 16:58:39 +0000, Ralf Baechle <ralf@linux-mips.org> said:
>> Right. There is however one bigger problem with the original patch:
>> It removes the driver for tx3912 and adds one for tx3927/tx49xx.
>> AFAICS, the 3912 has a very different register layout from the
>> other chips, so the old driver must not be removed yet.

ralf> Hmm...  Atushi sent me this new-style serial driver when I asked
ralf> him for replacements for the old style drivers in drivers/char/
ralf> so my undertanding was it was a full replacement for all of
ralf> them.  I'll check on the tx3912 and will try to send an update
ralf> later today.

Yes, Arnd is right.  tx3912 have been vanished from my memory.  Sorry
for confusion.  But I do not know if anybody still use the old tx3912
driver now (philips NINO support was removed from kernel a while ago).

---
Atsushi Nemoto
