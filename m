Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131804AbQKJWTY>; Fri, 10 Nov 2000 17:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131515AbQKJWTO>; Fri, 10 Nov 2000 17:19:14 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:32518 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131804AbQKJWS7>; Fri, 10 Nov 2000 17:18:59 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: sendmail fails to deliver mail with attachments in /var/spool/mqueue
Date: 10 Nov 2000 14:18:20 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8uhs7c$2hr$1@cesium.transmeta.com>
In-Reply-To: <3A0C3F30.F5EB076E@timpanogas.org> <3A0C6B7C.110902B4@timpanogas.org> <3A0C6E01.EFA10590@timpanogas.org> <26054.973893835@euclid.cs.niu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <26054.973893835@euclid.cs.niu.edu>
By author:    Neil W Rickert <sendmail+rickert@sendmail.org>
In newsgroup: linux.dev.kernel
>
> "Jeff V. Merkey" <jmerkey@timpanogas.org> wrote:
> 
> >The problem of dropping connections on 2.4 was related to the O RefuseLA
> >settings.  The defaults  in the RedHat, Suse, and OpenLinux RPMs are
> >clearly set too low for modern Linux kernels.  You may want them cranked
> >up to 100 or something if you want sendmail to always work.  
> 
> If a modern Linux kernel requires high load average defaults, I will
> stop using Linux.
> 

Numerically high load averages aren't inherently a bad thing.  There
isn't anything bad about a system with a loadavg of 20 if it does what
it should in the time you'd expect.  However, if your daemons start
blocking because they assume this number means badness, than that is
the problem, not the loadavg in itself.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
