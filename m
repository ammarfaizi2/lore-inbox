Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130599AbRAGVnG>; Sun, 7 Jan 2001 16:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132140AbRAGVm4>; Sun, 7 Jan 2001 16:42:56 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:39954 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130599AbRAGVmn>; Sun, 7 Jan 2001 16:42:43 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Cyrix III boot fix and bug report
Date: 7 Jan 2001 13:42:27 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <93ans3$bd4$1@cesium.transmeta.com>
In-Reply-To: <20010107201952.C10035@nightmaster.csn.tu-chemnitz.de> <E14FKZL-000367-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E14FKZL-000367-00@the-village.bc.nu>
By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
In newsgroup: linux.dev.kernel
>
> >    3DNOW extensions for Cyrix III via rdmsr from 0x80000001. This
> >    fails with an exception, that is not handled and thus we oops
> >    on boot.
> 
> Interesting. Ok.  We can set the bit unconditionally it seems.
> 

Does it appear in CPUID?  If so, we shouldn't need to mess with this
crap at all.

(Could this code have been written by someone who was confused between
MSR 0x80000001 and CPUID 0x80000001?)

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
