Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130850AbQLCHwc>; Sun, 3 Dec 2000 02:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130871AbQLCHwV>; Sun, 3 Dec 2000 02:52:21 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:57872 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130850AbQLCHwL>; Sun, 3 Dec 2000 02:52:11 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: /dev/random probs in 2.4test(12-pre3)
Date: 2 Dec 2000 23:20:33 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <90cs81$6vv$1@cesium.transmeta.com>
In-Reply-To: <3A295EA3.F0E47E9@linux.com> <200012022200.eB2M0Wu473578@saturn.cs.uml.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200012022200.eB2M0Wu473578@saturn.cs.uml.edu>
By author:    "Albert D. Cahalan" <acahalan@cs.uml.edu>
In newsgroup: linux.dev.kernel
> 
> Yeah, people write annoying little wrapper functions that
> bounce right back into the kernel until the job gets done.
> This is slow, it adds both source and object bloat, and it
> is a source of extra bugs. What a lovely API, eh?
> 
> The fix: write_write_write_damnit() and read_read_read_damnit(),
> which go until they hit a fatal error or complete the job.
> 

RTFM(fwrite), RTFM(fread).

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
