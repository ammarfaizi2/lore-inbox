Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262482AbUKLCC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbUKLCC4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 21:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbUKLCCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 21:02:55 -0500
Received: from smtpout.mac.com ([17.250.248.44]:1484 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262458AbUKLCBs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 21:01:48 -0500
In-Reply-To: <Pine.LNX.4.58.0411111507090.2301@ppc970.osdl.org>
References: <200411112302.iABN2Pu01711@apps.cwi.nl> <Pine.LNX.4.58.0411111507090.2301@ppc970.osdl.org>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <CB00AF16-344E-11D9-857E-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, Andries.Brouwer@cwi.nl
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] remove if !PARTITION_ADVANCED condition in defaults
Date: Thu, 11 Nov 2004 21:01:40 -0500
To: Linus Torvalds <torvalds@osdl.org>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 11, 2004, at 18:11, Linus Torvalds wrote:
> Actually, we should make MSDOS_PARTITION not ask at all, unless
> CONFIG_EMBEDDED is set.

My dual 1GHz G4 isn't an embedded system by any means, but I don't
want to load crappy MSDOS partition drivers into it, it's intended to
have a blazingly fast boot time with minimal extra drivers.

> That's really what EMBEDDED means: ask about things that no sane person
> would leave out. So how about just changing that "if 
> PARTITION_ADVANCED"
> into "if EMBEDDED" on MSDOS?

If you make this specific to x86, that _may_ be OK, but I suspect 
others who
only have only BSD partitioning schemes may object.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a17 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


