Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271921AbRIVSX2>; Sat, 22 Sep 2001 14:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271928AbRIVSXU>; Sat, 22 Sep 2001 14:23:20 -0400
Received: from mail.eunet.ch ([146.228.10.7]:5 "EHLO mail.kpnqwest.ch")
	by vger.kernel.org with ESMTP id <S271921AbRIVSXI>;
	Sat, 22 Sep 2001 14:23:08 -0400
Message-ID: <3BACF2E7.3AFC201E@dial.eunet.ch>
Date: Sat, 22 Sep 2001 20:21:59 +0000
From: Mario Vanoni <vanonim@dial.eunet.ch>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.10-pre14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: 2.4.9-pre13aa1 & 2.4.9-pre14: SMP + 3c59x: feature/bug?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dual SMP PIII550 BX400 1024MB mem
according "Documentation/Changes" all >= update.

Both kernels compiled *_without_* modules:
lilo.conf with append="ether=0,0,3,eth0".
Ethernet doesn't work anymore,
with 2.2.19pre#aa#, 2.2.20pre#aa# perfect.

Both kernels compiled with 3c59x as module:
modules.conf:
alias eth0 3c59x
options 3c59x options=3
obviously without append in lilo.conf.
Ethernet works as usual.

No difference on all other application.

Regards

Mario, not in lkml!
