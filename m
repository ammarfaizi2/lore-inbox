Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262467AbSI2NHw>; Sun, 29 Sep 2002 09:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262468AbSI2NHw>; Sun, 29 Sep 2002 09:07:52 -0400
Received: from gzp11.gzp.hu ([212.40.96.53]:51212 "EHLO gzp11.gzp.hu")
	by vger.kernel.org with ESMTP id <S262467AbSI2NHv>;
	Sun, 29 Sep 2002 09:07:51 -0400
To: linux-kernel@vger.kernel.org
From: "Gabor Z. Papp" <gzp@myhost.mynet>
Subject: Re: 2.4.20-pre7-ac3 spurious 8259A interrupt
References: <1333.3d96c7c1.d91c5@gzp1.gzp.hu> <3D96FAA4.F328E3D5@bigpond.com>
Organization: Who, me?
User-Agent: tin/1.5.14-20020926 ("Soil") (UNIX) (Linux/2.4.20-pre8 (i686))
Message-ID: <4e8f.3d96fc6a.25ce2@gzp1.gzp.hu>
Date: Sun, 29 Sep 2002 13:13:14 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Allan Duncan <allan.d@bigpond.com>:

| You don't say what chipset the m/b uses.

Intel Corp. 82815 815 Chipset Host Bridge and Memory Controller Hub (rev 4).

| I see this message once, near boot time, on a VIA KT266A,
| unless I use a RedHat patched kernel.  Haven't managed to
| find what they did to stop it though.

I see sometimes with IRQ7 which is unused... and on heavy
ide1 usage on the ide1 interrupt. Weird, and never happend
with earlier 2.4.x kernels.

