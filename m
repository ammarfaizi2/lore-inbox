Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129591AbQKGXZu>; Tue, 7 Nov 2000 18:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130556AbQKGXZl>; Tue, 7 Nov 2000 18:25:41 -0500
Received: from tungsten.btinternet.com ([194.73.73.81]:65214 "EHLO
	tungsten.btinternet.com") by vger.kernel.org with ESMTP
	id <S129591AbQKGXZ2>; Tue, 7 Nov 2000 18:25:28 -0500
From: davej@suse.de
Date: Tue, 7 Nov 2000 23:24:54 +0000 (GMT)
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: jmerkey@timpanogas.org
Subject: Re: Installing kernel 2.4
Message-ID: <Pine.LNX.4.21.0011072322120.8187-100000@neo.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> There are tests for all this in the feature flags for intel and
> non-intel CPUs like AMD -- including MTRR settings.  All of this could
> be dynamic.  Here's some code that does this, and it's similiar to
> NetWare.  It detexts CPU type, feature flags, special instructions,
> etc.  All of this on x86 could be dynamically detected.

Detecting the CPU isn't the issue (we already do all this), it's what to
do when you've figured out what the CPU is. Show me code that can
dynamically adjust the alignment of the routines/variables/structs
dependant upon cacheline size.

regards,

Davej.

-- 
| Dave Jones <davej@suse.de>  http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
