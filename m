Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266574AbUBLUl4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 15:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266576AbUBLUl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 15:41:56 -0500
Received: from ncc1701.cistron.net ([62.216.30.38]:47266 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S266574AbUBLUly
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 15:41:54 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: (was Re: [RFC] IDE 80-core cable detect - chipset-specific code to over-ride eighty_ninty_three())
Date: Thu, 12 Feb 2004 20:41:53 +0000 (UTC)
Organization: Cistron Group
Message-ID: <c0goeh$hs4$1@news.cistron.nl>
References: <200402122106.41947.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1076618513 18308 62.216.29.200 (12 Feb 2004 20:41:53 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200402122106.41947.bzolnier@elka.pw.edu.pl>,
Bartlomiej Zolnierkiewicz  <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
>
>Hi,
>
>word93 of drive identify is:
>
>0x603b for IC35L120AVV207-0
>0x3469 for QUANTUM FIREBALLlct20 30
>
>and eighty_ninty_three() checks for bit 0x4000, so...
>
>Willy, it seems you are hitting some other problem.
>Have you already tried booting with "ide0=ata66"?

That reminds me, there is currenly no way to boot with
ide0=ata33, right ?

I have a tyan motherboard with a serverworks chipset, and the
(2.5" system-) disk is connected with a 40 pins cable. However
the serverworks chipset doesn't detect this, and tries to run
it in UDMA<lots> mode. That results in lots of nasty messages
before it falls back to UDMA33 mode.

Could you put a way to force it into UDMA33 (UDMA2) mode on the
wishlist, please ?

Mike.

