Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129777AbRAMTY5>; Sat, 13 Jan 2001 14:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129763AbRAMTYr>; Sat, 13 Jan 2001 14:24:47 -0500
Received: from quechua.inka.de ([212.227.14.2]:7004 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S129777AbRAMTYf>;
	Sat, 13 Jan 2001 14:24:35 -0500
From: Bernd Eckenfels <inka-user@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: BUG in 2.4.0: dd if=/dev/random of=out.txt bs=10000 count=100
Message-Id: <E14HWHz-0004ru-00@sites.inka.de>
Date: Sat, 13 Jan 2001 20:24:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010113035314.316.qmail@web5205.mail.yahoo.com> you wrote:
> If I do the dd line in the title under 2.4.0 I get an
> out.txt file of 591 bytes.
/dev/random will only give you as much bytes as are available. and even then
you should not do it cause you drain the random pool. Use /dev/urandom
instead.

Greetings
Bernd
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
