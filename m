Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129800AbQKOWEt>; Wed, 15 Nov 2000 17:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130485AbQKOWEk>; Wed, 15 Nov 2000 17:04:40 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:43277 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129800AbQKOWE0>; Wed, 15 Nov 2000 17:04:26 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: test11-pre5, Athlon, and Machine Check Architecture
Date: 15 Nov 2000 13:34:20 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8uuvgs$1u1$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0011152107420.2791-100000@neo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.21.0011152107420.2791-100000@neo.local>
By author:    davej@suse.de
In newsgroup: linux.dev.kernel
>
> 
> > However, since at least AMD Athlon actually advertises MCA, I would
> > like to verify that the code works on these processors before
> > submitting it to Linus.
> 
> The Athlon MCA is basically the same architecture-wise as Pentium Pro/II
> But there are some differences..  Until AMD make document 21656 (BIOS
> writers guide) public (or even a subset of it), we'll not be able to take
> advantage of these extra features.
> 
> I'd suggest that until this happens, we leave bluesmoke.c Intel only.
> 

That's completely the wrong way to look at it.  AMD are certainly free
to add features, what they aren't free to do is making code that
expects the documented behaviour fail -- and if so, it's their bug.  I
have so far gotten no indication that that is the case; the only thing
I have gotten so far is a positive report that it at least doesn't do
the wrong thing in the no-#MF case.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
