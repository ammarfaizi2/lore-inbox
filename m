Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264837AbUD1PEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264837AbUD1PEJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 11:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264856AbUD1PEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 11:04:09 -0400
Received: from zone3.gcu-squad.org ([217.19.50.74]:51983 "EHLO
	zone3.gcu-squad.org") by vger.kernel.org with ESMTP id S264837AbUD1PEF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 11:04:05 -0400
Message-ID: <1083164773.408fc86533f29@imp.gcu.info>
Date: Wed, 28 Apr 2004 17:06:13 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Stefan Eletzhofer <stefan.eletzhofer@eletztrick.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] add RTC 8564 I2C chip support
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2 / FreeBSD-4.6.2
X-Originating-IP: 62.23.237.138
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

Just a quick comment about your patch: it's a common habit of the
sensors folks to prefix i2c bus drivers with i2c-, but not chip
drivers. So I would suggest that you name your driver rtc8564, not
i2c-rtc8564.

Also, please keep the lines in drivers/i2c/chips/Makefile in the
alphabetic order. And your header states
"linux/drivers/system3/rtc8564.c" while the driver will be in a
different location. Please correct.

I've not read your code otherwise, I don't know anything about RTCs.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

