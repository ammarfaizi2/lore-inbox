Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131310AbRAQXVc>; Wed, 17 Jan 2001 18:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131378AbRAQXV0>; Wed, 17 Jan 2001 18:21:26 -0500
Received: from gatekeeper.kati.fi ([194.197.204.34]:41737 "EHLO
	gatekeeper.kati.fi") by vger.kernel.org with ESMTP
	id <S131310AbRAQXVK>; Wed, 17 Jan 2001 18:21:10 -0500
Date: Thu, 18 Jan 2001 01:13:09 +0200 (EET)
From: Juhani Rautiainen <jrauti@kati.fi>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: VIA VT82C686 serial port over 115200
Message-ID: <Pine.LNX.4.10.10101180042280.3437-100000@sasu1.kati.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've made little kernel module which enables high speed modes (230Kb and
460Kb) with VIA VT82C686* southbridge equipped motherboards. I've been using
module with ISDN-TA and haven't had any problems. If you want to try
module it's available at http://www.kati.fi/viahss/viahss-0.9.tar.gz.
Some brief documentation can be found at http://www.kati.fi/viahss/ 
(read this before using module).

This is my first try with kernel modules so you can consider yourself 
warned. My huge test team (2 people) have tested module with both 686A and
686B chipsets and it seems to work. Module does same as SHSMOD
patches but doesn't require serial driver patching. So if you have ISDN-TA
and serial port limits it's speed give this module a try.

Module works with 2.4 kernels but I don't see any reason why it shouldn't
work with 2.2 kernels.

-- 
Juhani Rautiainen			jrauti@iki.fi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
