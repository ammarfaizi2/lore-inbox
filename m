Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287881AbSABR2t>; Wed, 2 Jan 2002 12:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287887AbSABR2j>; Wed, 2 Jan 2002 12:28:39 -0500
Received: from zeus.kernel.org ([204.152.189.113]:21921 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S287885AbSABR2b>;
	Wed, 2 Jan 2002 12:28:31 -0500
Date: Wed, 2 Jan 2002 18:21:25 +0100 (CET)
From: Krzysztof Oledzki <ole@ans.pl>
X-X-Sender: <ole@dark.pcgames.pl>
To: Brian <hiryuu@envisiongames.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Two hdds on one channel - why so slow?
In-Reply-To: <0GPA00BK988OBK@mtaout45-01.icomcast.net>
Message-ID: <Pine.LNX.4.33.0201021808490.9573-100000@dark.pcgames.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 1 Jan 2002, Brian wrote:

> This is an inherent quirk (SCSI folks would say brain damage) in IDE.
>
> Only one drive on an IDE chain may be accessed at once and only one
> request may go to that drive at a time.  Therefore, the maximum you could
> hope for in that test is half speed on each.  Throw in the overhead of
> continuously hopping between them and 12MB is no surprise.

So?!? This ATA100 and ATA133 standards do not make any sens? It is not
possible to have more than 66 MB/sec with on drive and is seems that it is
not possible to use more than ~30MB/sek of 100 or 133 MB/sec ATA100/133
bus speed with two HDDs. Oh :(((

Another question - why ATA100/ATA66 HDDs are so slow with UDMA33?
With new IBM 60 GB IC35L060AVER07-0 I have much more than 33 MB/sec with
ATA100 and only 24 MB/sec with UDMA33 (Asus P2B with IntelBX). New 80GB Seagates
(Baracuda IV) have the same problem.

Best regards,

			Krzysztof Oledzki

