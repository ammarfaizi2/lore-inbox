Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932554AbVHJKPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554AbVHJKPL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 06:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbVHJKPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 06:15:11 -0400
Received: from [213.91.10.50] ([213.91.10.50]:10981 "EHLO zone4.gcu-squad.org")
	by vger.kernel.org with ESMTP id S932554AbVHJKPK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 06:15:10 -0400
Date: Wed, 10 Aug 2005 12:06:59 +0200 (CEST)
To: salahx@yahoo.com
Subject: Re: I2C block reads with i2c-viapro: testers wanted
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <OlUL6TaR.1123668419.1485260.khali@localhost>
In-Reply-To: <42F95E9E.90204@yahoo.com>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (zone4.gcu-squad.org [127.0.0.1]); Wed, 10 Aug 2005 12:06:59 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Salah,

[Salah Coronya]
> I have a VT8235 chipset, I applied the patch to my kernel
> (2.6.12-gentoo-r6), compared the "before" and "after" eeproms in /sys
> with diff and they are the same.

Beware that eeprom files are binary files, so "diff" might not be the
more suitable tool for the job. "cmp" would probably do better.
Nevertheless, I think I remember that diff can at least differenciate
between identical and different binary files, so your test must still be
valid.

> So it seems to work with VT8235.

Yes, it does. Antonino A. Daplas reported success on his VT8235 in
private as well, so I am now confident that this chip is OK. The
question remains for VT82C686A and B though.

Thanks for your help!
--
Jean Delvare
