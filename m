Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286971AbRL1ShG>; Fri, 28 Dec 2001 13:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286981AbRL1Sg6>; Fri, 28 Dec 2001 13:36:58 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28679 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286980AbRL1Sgx>; Fri, 28 Dec 2001 13:36:53 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: zImage not supported for 2.2.20?
Date: 28 Dec 2001 10:36:44 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a0ie3s$s71$1@cesium.transmeta.com>
In-Reply-To: <4.3.2.7.2.20011228124704.00abba70@192.168.124.1> <20011228121228.GA9920@emma1.emma.line.org> <4.3.2.7.2.20011228124704.00abba70@192.168.124.1> <4.3.2.7.2.20011228173505.00aa3da0@192.168.124.1>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <4.3.2.7.2.20011228173505.00aa3da0@192.168.124.1>
By author:    Roy Hills <linux-kernel-l@nta-monitor.com>
In newsgroup: linux.dev.kernel
> 
> Unfortunately, I need to use zImage on my Tecra.  I know that zImage is
> old, and I've heard that support for it will eventually be withdrawn, but I
> don't really have much alternative right now unless there is a patch which
> works around the Tecra's buggy A20 handling.
> 

I believe this is now a myth.  Toshiba's weird A20 problems should
have been worked around for a long, long time; and I believe the
latest set of changes in 2.4 should make that thouroughly complete.
In fact, if your bzImages don't work either, I suspect your problems
isn't at all one of zImage vs bzImage but that there is a separate bug
that's biting you independently.

> Does anyone know the status of zImage format in modern kernels?
> Is it _supposed_ to be supported under 2.2.recent?  How about 2.4.recent?
> 
> I guess that, if zImage is supposed to be supported, then I have a
> genuine bug.  However, if zImage support has officially been
> dropped, then it's a different matter - in this case, the only bug
> would be that the Makefile should issue a sensible message when you
> try to "make zImage" rather than producing a kernel that won't work.

zImage format will probably be removed in the 2.5 series.  It's
virtually impossible to fit a practical 2.4 kernel within the zImage
size limits.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
