Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132477AbRAXVLs>; Wed, 24 Jan 2001 16:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132474AbRAXVLi>; Wed, 24 Jan 2001 16:11:38 -0500
Received: from detroit.gci.com ([205.140.80.57]:14089 "EHLO daytona.gci.com")
	by vger.kernel.org with ESMTP id <S132465AbRAXVLT>;
	Wed, 24 Jan 2001 16:11:19 -0500
Message-ID: <BF9651D8732ED311A61D00105A9CA3150351585F@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: linux-kernel@vger.kernel.org
Subject: RE: Error compiling for sparc64
Date: Wed, 24 Jan 2001 12:11:11 -0900
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller [davem@redhat.com] wrote:

> Wrong, your one-line fix may make it build correctly but it
> will not produce working quota 32-bit syscall code there.
> 
> Someone needs to fixup the conversion code, I don't have time to track
> the AC series (it actually duplicates a lot of networking stuff I just
> pushed to Linus and ended up in 2.4.1-pre10) which means it likely
> won't be fixed until Linus takes those quota code changes.
> 
> Please stick to 2.4.1-preX on sparc64, and if using 2.4.1-pre10 please
> apply this patch to get a clean build :-)

Hmm.  Well, this i can understand.  I'm not using quotas, so I probably
wouldn't have ever introduced any bugs. I don't have a lot of time to
try to understand the quota system, so I was just looking for the quick fix.

I'll rebuild under 2.4.1-pre10 with the patch and see how things go from
there.

Thanks,

Leif
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
