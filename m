Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129804AbQKBAe6>; Wed, 1 Nov 2000 19:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130641AbQKBAej>; Wed, 1 Nov 2000 19:34:39 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:35853 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129804AbQKBAec>; Wed, 1 Nov 2000 19:34:32 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Where did kgcc go in 2.4.0-test10 ?
Date: 1 Nov 2000 16:32:48 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8tqcng$d8p$1@cesium.transmeta.com>
In-Reply-To: <20001101234058.B1598@werewolf.able.es> <200011012345.PAA20284@pizda.ninka.net> <20001101172100.A5081@fsmlabs.com> <200011020011.QAA20585@pizda.ninka.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200011020011.QAA20585@pizda.ninka.net>
By author:    "David S. Miller" <davem@redhat.com>
In newsgroup: linux.dev.kernel
> 
> We already know we are a bunch of pinheads wrt. the userland compiler
> issue, full stop.  It need not be restated several hundred more times.
> Believe me, after such a large fiasco, we have listened :-)
> 
> But, on the other hand, to say that "kgcc" comceptually is something
> only Red Hat has ever done is a factual error, that is all I am trying
> to state, nothing more.
> 

I think at least supporting a "kgcc" compiler makes sense,
conceptually (although it probably should have been called "kcc", but
it's too late now.)

The kernel uses a lot of gcc extensions, and history shows that these
extensions aren't as stable as the compiler system as a whole.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
