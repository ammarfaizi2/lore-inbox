Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129047AbQKKBeN>; Fri, 10 Nov 2000 20:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129061AbQKKBeD>; Fri, 10 Nov 2000 20:34:03 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:6148 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129047AbQKKBdr>; Fri, 10 Nov 2000 20:33:47 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Where is it written?
Date: 10 Nov 2000 17:33:34 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8ui7le$c9a$1@cesium.transmeta.com>
In-Reply-To: <8ui698$c2q$1@cesium.transmeta.com> <11198.973906134@ocs3.ocs-net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <11198.973906134@ocs3.ocs-net>
By author:    Keith Owens <kaos@ocs.com.au>
In newsgroup: linux.dev.kernel
>
> On 10 Nov 2000 17:10:00 -0800, 
> "H. Peter Anvin" <hpa@zytor.com> wrote:
> >We can mess with the ABI, but it requires a wholescale rev of the
> >entire system.
> 
> AFAICT, there is nothing stopping us from redoing the kernel ABI to
> pass the first few parameters between kernel functions in registers.
> As long as the syscall interface is unchanged, that ABI change will
> only break binary modules (care_factor == 0).  The ABI type would need
> to be added to the symbol version prefix, trivial.
> 

Yes, the kernel is very different; however, the big win for an ABI
change is in user space.

AFAIK, I think Linus tried this once, but ran into bugs in gcc.  We
might very well try again in 2.5.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
