Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129650AbQKIARJ>; Wed, 8 Nov 2000 19:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129488AbQKIAQt>; Wed, 8 Nov 2000 19:16:49 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:4625 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129324AbQKIAQp>; Wed, 8 Nov 2000 19:16:45 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Pentium IV-summary
Date: 8 Nov 2000 16:16:21 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8ucqcl$p2b$1@cesium.transmeta.com>
In-Reply-To: <20001108214759.D17544@khan.acc.umu.se> <E13tdxo-0000W1-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E13tdxo-0000W1-00@the-village.bc.nu>
By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
In newsgroup: linux.dev.kernel
>
> > Is this revamp only for processors that actually support the
> > CPUID-instruction, or will you fix the CPU-detection for non-CPUID
> > processors too?! There are quite a few processors that can be detected
> > properly but aren't (for instance, IBM 486slc/slc2/slc3)
> 
> Linus refused code to ident the ones that didnt matter because the code was
> (neccessarily) obscure, weird and didn't change anything but the string in
> procfs.
> 

It should be a lot cleaner to do that kind of stuff -- if you feel
it's worth bothering to -- in my changed version.  It's taking a bit
longer than I'd like, because I keep uncovering, ahem, "issues" with
the current code that can be easily fixed once one adds a real
framework for these things.  I hopefully will have something RSN.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
