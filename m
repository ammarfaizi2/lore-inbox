Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266473AbSLJBnN>; Mon, 9 Dec 2002 20:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266487AbSLJBnN>; Mon, 9 Dec 2002 20:43:13 -0500
Received: from 64-60-75-69.cust.telepacific.net ([64.60.75.69]:8452 "EHLO
	racerx.ixiacom.com") by vger.kernel.org with ESMTP
	id <S266473AbSLJBnM>; Mon, 9 Dec 2002 20:43:12 -0500
Message-ID: <3DF54765.2020505@ixiacom.com>
Date: Mon, 09 Dec 2002 17:46:13 -0800
From: Dan Kegel <dkegel@ixiacom.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
MIME-Version: 1.0
To: Daniel.Heater@gefanuc.com, linux-kernel@vger.kernel.org
Subject: re: [RFC] countdown timer driver
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Questions:
> 1. Is there already a standard kernel interface to this type of timer?

The Posix high-res timer stuff, I think.  Have you tried expressing
what you want user programs to do in terms of Posix high-res timers yet?

> 2. Is there any reason to interface/integrate this type of device with the
>    high-res timer stuff currently under development for the 2.5 kernel?

Yes; perhaps you could create a service provider interface
for the posix high-res timer stuff, then use that SPI
to plug your hardware in?

I may be way off base here, but it does seem like it's due dilligence
to verify that you're not reinventing an interface here.
- Dan




