Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbQKDBBt>; Fri, 3 Nov 2000 20:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129066AbQKDBBj>; Fri, 3 Nov 2000 20:01:39 -0500
Received: from gadolinium.btinternet.com ([194.73.73.111]:57085 "EHLO
	gadolinium.btinternet.com") by vger.kernel.org with ESMTP
	id <S129033AbQKDBBX>; Fri, 3 Nov 2000 20:01:23 -0500
From: davej@suse.de
Date: Sat, 4 Nov 2000 01:01:06 +0000 (GMT)
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86 boot time check for cpu features
Message-ID: <Pine.LNX.4.21.0011040056380.6163-100000@neo.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote..

> > Hmm, after a bit more investigation, it appears that the Cyrix MII
> > processors support cmov instructions, even though we currently don't
> > compile for that processor with -march=i686.  Please ignore this patch
> > until I can come up with something better.

> I believe the MII always has CPUID enabled. It was the older Cyrixes
> that did not.

That was my understanding also.

d.

-- 
| Dave Jones <davej@suse.de>  http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
