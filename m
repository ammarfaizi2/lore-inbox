Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319407AbSILBvS>; Wed, 11 Sep 2002 21:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319408AbSILBvS>; Wed, 11 Sep 2002 21:51:18 -0400
Received: from mta06ps.bigpond.com ([144.135.25.138]:32978 "EHLO
	mta06ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S319407AbSILBvR>; Wed, 11 Sep 2002 21:51:17 -0400
Message-ID: <3D7FF444.87980B8E@bigpond.com>
Date: Thu, 12 Sep 2002 11:56:20 +1000
From: Allan Duncan <allan.d@bigpond.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.20-pre4 & ff. blows away Xwindows with Matrox G400 and agpgart
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a reissue of an earlier report, and I've since done some more digging.

Up to kernel 2.4.20-pre2 there was no problem, agpgart et al ran fine etc,
but from 2.4.20-pre4 onwards when Xwindows starts to load these modules
I am instantly thrown back to a booting machine.
The same kernels on a VIA MVP3 chipset box with a Matrox G200 are fine.

I have ascertained that any attempt to use agpgart triggers it.

Rather than clutter up the list with lots of log files, I've made a web page at
http://www.users.bigpond.com/allan.d/bug/Matrox.html
with all the info I could gather.

Any suggestions of how to improve the error messages around the failure point
are welcome.  Nothing is written into dmesg at the time of failure.
