Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262934AbTFGKVa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 06:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262942AbTFGKVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 06:21:30 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:247 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262934AbTFGKV1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 06:21:27 -0400
Date: Sat, 7 Jun 2003 12:34:28 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Margit Schubert-While <margitsw@t-online.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re:[TRIV-PATCH] Better CONFIG_X86_GENERIC description (was:  Re:
 Generic x86 support in 2.5.70-bk)
In-Reply-To: <5.1.0.14.2.20030607103950.00af14e8@pop.t-online.de>
Message-ID: <Pine.SOL.4.30.0306071230320.12011-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Its okay. You want the biggest possible X86_L1_CACHE_SHIFT for
X86_GENERIC, and it is the one for MPENTIUM4 (128 bytes).
Otherwise you will degrade performance on P4 when running generic kernel.

Regards,
--
Bartlomiej

On Sat, 7 Jun 2003, Margit Schubert-While wrote:

> Hmm, as a side note, looking at arch/i386/Kconfig, the following
> looks very suspect :
>
> config X86_L1_CACHE_SHIFT
>          int
>          default "7" if MPENTIUM4 || X86_GENERIC
>
> Margit


