Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268522AbTCAMmr>; Sat, 1 Mar 2003 07:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268527AbTCAMmq>; Sat, 1 Mar 2003 07:42:46 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:35265 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S268522AbTCAMmn>;
	Sat, 1 Mar 2003 07:42:43 -0500
Date: Sat, 1 Mar 2003 13:53:01 +0100 (MET)
From: Mikael Pettersson <mikpe@user.it.uu.se>
Message-Id: <200303011253.h21Cr1i4013408@harpo.it.uu.se>
To: blues@ds.pg.gda.pl
Subject: Re: 2.4.20 DVD DMA problem
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Mar 2003 10:34:59 +0100 (CET), =?ISO-8859-2?Q?Pawe=B3_Go=B3aszewski?= wrote:
>Try this:  http://www.ans.pl/ide/testing/
>It's backport of IDE subsystem from 2.4 - works really nice.

Based on 2.4.20 or 2.4.21-pre?

I've been porting Andre's big 2.2.19 IDE patch up to 2.2.23 since
I need it for UDMA100 support on Intel ICH and PDC20267, but it
doesn't support UDMA100 on my 20269. The 2.4.21-pre IDE code supports
it, but, as far as I know, relies on PCI layer changes which could
make it difficult to backport to 2.2.

/Mikael
