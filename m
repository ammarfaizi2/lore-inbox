Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269606AbTGJS4J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 14:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269605AbTGJS4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 14:56:09 -0400
Received: from foo209.internut.com ([209.181.68.209]:60336 "EHLO bartman")
	by vger.kernel.org with ESMTP id S269607AbTGJSz7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 14:55:59 -0400
From: "Chuck Luciano" <chuck@mrluciano.com>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: My own 3.5G patch plus question on Ingo's 4G/$G patch
Date: Thu, 10 Jul 2003 13:09:16 -0600
Message-ID: <NFBBKNADOLMJPCENHEALKEAHGBAA.chuck@mrluciano.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I've been working on a patch for 2.4.18 that allows PAGE_OFFSET
to be set on boundarys other then 1GB multiples. I started with
a patch that I got from Martin Bligh and back ported it to 2.4.18.

http://www.mrluciano.com/chuck/linux-2.4.18-unaligned.patch

I'll apologize in advance for not having figured out how the configure
system works, so, when you apply this patch it's on. Also, you have to
edit vmlinux.lds AND page.h to move the boundary.

Anyway, I now need to propagate this patch forward to 2.4.20 and wanted
to get it out there for other people to look at.

I will do the config thing when I do this port.

--------

On the subject of the 4G/4G patch, I started with 2.5.74, added 
patch-2.5.74-bk1 and http://redhat.com/~mingo/4g-patches/4g-2.5.74-F8
and I get a hunk that fails:

patching file include/asm-i386/mmu_context.h
Hunk #1 FAILED at 29.
Hunk #2 succeeded at 38 (offset -5 lines).
Hunk #4 FAILED at 75.
2 out of 4 hunks FAILED -- saving rejects to file include/asm-i386/mmu_context.h.rej

Is/are there a patch(es) that I'm missing?

I'm pretty new to hacking on the linux kernel.

Chuck Luciano
chuck@mrluciano.com


