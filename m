Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbTDYBTA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 21:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263025AbTDYBTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 21:19:00 -0400
Received: from sj-core-2.cisco.com ([171.71.177.254]:5316 "EHLO
	sj-core-2.cisco.com") by vger.kernel.org with ESMTP id S263019AbTDYBS7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 21:18:59 -0400
From: "Hua Zhong" <hzhong@cisco.com>
To: "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Fix SWSUSP & !SWAP
Date: Thu, 24 Apr 2003 18:31:00 -0700
Message-ID: <CDEDIMAGFBEBKHDJPCLDMEBCDMAA.hzhong@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
In-Reply-To: <b8a2le$p88$1@cesium.transmeta.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It would be nice, so GRUB has no problem any more for using journaling file
system on boot partition.

> Shouldn't we be syncing them all before the suspend anyway, to
> minimize corruption in case the user chooses to mount the filesystem
> *without* resuming (think a dual-boot configuration.)  This would be
> another application for the "supersync" operation that was discussed
> at OLS 2002 -- a need for an operation which not only flushes all
> blocks to disk but also forces the journal to be replayed and
> truncated.
>
> 	-hpa
>
> --
> <hpa@transmeta.com> at work, <hpa@zytor.com> in private!
> "Unix gives you enough rope to shoot yourself in the foot."
> Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

