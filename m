Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275334AbRIZQ6t>; Wed, 26 Sep 2001 12:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275333AbRIZQ6i>; Wed, 26 Sep 2001 12:58:38 -0400
Received: from mail.berlin.de ([195.243.105.33]:3530 "EHLO
	mailoutvl21.berlin.de") by vger.kernel.org with ESMTP
	id <S275331AbRIZQ6d>; Wed, 26 Sep 2001 12:58:33 -0400
Message-ID: <3BB20949.19469C6F@berlin.de>
Date: Wed, 26 Sep 2001 18:58:49 +0200
From: Norbert Roos <n.roos@berlin.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: System hangs during interruptible_sleep_on_timeout() under 2.4.9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!

When I call interruptible_sleep_on_timeout(), the complete systems
stops/hangs, even with small timeout values. This happens only on an
Abit KT7A (VIA chip set) motherboard with an Athlon processor, other
motherboards (different manufactors) behave normally.

I call the function during the initialization of a PCI device, but
during the sleep the device is not generating traffic on the PCI bus.

Any idea where this might come from?

I'm using kernel version 2.4.9.

bye
Norbert
