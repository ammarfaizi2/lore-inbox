Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129851AbQKHUhP>; Wed, 8 Nov 2000 15:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129849AbQKHUhG>; Wed, 8 Nov 2000 15:37:06 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:33540 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129724AbQKHUgy>; Wed, 8 Nov 2000 15:36:54 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Pentium IV-summary
Date: 8 Nov 2000 12:36:21 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8ucdg5$npt$1@cesium.transmeta.com>
In-Reply-To: <379322493.973714466779.JavaMail.root@web346-wra.mail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <379322493.973714466779.JavaMail.root@web346-wra.mail.com>
By author:    Frank Davis <fdavis112@juno.com>
In newsgroup: linux.dev.kernel
> 
> 2. There's a bug in get_model_name(),
>    cpuid(0x80000001, &dummy, &dummy, &dummy, &(c->x86_capability));
> 
> that overwrites the capability state. It will be fixed in 2.2.18 by
> Dave Jones. Should we also look at Peter Anvin's fix for the problem
> that Linus mentioned? What are the other features of the Pentium IV
> should be included in the kernel pending the capability state fix?
> 

I'm working on a revamp of the i386 CPUID detection code, which will
fix this problem as a side effect.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
