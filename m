Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267453AbTATTyI>; Mon, 20 Jan 2003 14:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267273AbTATTx7>; Mon, 20 Jan 2003 14:53:59 -0500
Received: from h-64-105-35-85.SNVACAID.covad.net ([64.105.35.85]:2030 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267248AbTATTww>; Mon, 20 Jan 2003 14:52:52 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 20 Jan 2003 12:01:48 -0800
Message-Id: <200301202001.MAA15032@adam.yggdrasil.com>
To: brand@jupiter.cs.uni-dortmund.de
Subject: Re: Patch?: linux-2.5.59/sound/soundcore.c referenced non-existant errno variable
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I failed to complete a sentence in my previous reply:

>        In both cases, the compiler is normally going to put all of
>error handling code after all of the success code, so the only extra
>instructions read into the cache will be from the tail end of the

	...cache line containing the "return success" code.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
