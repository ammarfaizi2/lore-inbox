Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129069AbQKODsi>; Tue, 14 Nov 2000 22:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129040AbQKODs3>; Tue, 14 Nov 2000 22:48:29 -0500
Received: from hera.cwi.nl ([192.16.191.1]:30670 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129057AbQKODsQ>;
	Tue, 14 Nov 2000 22:48:16 -0500
Date: Wed, 15 Nov 2000 04:18:13 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200011150318.EAA130951.aeb@aak.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: crash of 2.4.0t11p5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been using (a heavily patched) 2.4.0test9 since it was released
and have not seen any problems that I can recall.  Booted (vanilla)
2.4.0test11pre5 a moment ago, but after
	insmod ipchains.o
	rsh foo
	ping bar
the machine was completely dead immediately -
no ping/console change/.., no log messages -
a real ping of death.
(This machine would forward from foo to bar. This happened
while copying a disk to another disk using dd.)

Andries

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
