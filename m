Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318963AbSIIVCf>; Mon, 9 Sep 2002 17:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318962AbSIIVCf>; Mon, 9 Sep 2002 17:02:35 -0400
Received: from packet.digeo.com ([12.110.80.53]:6610 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S318963AbSIIVC0>;
	Mon, 9 Sep 2002 17:02:26 -0400
Message-ID: <3D7D0D62.A4803A4E@digeo.com>
Date: Mon, 09 Sep 2002 14:06:42 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.32 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "David S. Miller" <davem@redhat.com>, rusty@rustcorp.com.au, pavel@suse.cz,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       akpm@zip.com.au
Subject: Re: [PATCH] Important per-cpu fix.
References: <20020909.011539.122194350.davem@redhat.com> <1031605086.29718.43.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2002 21:06:57.0942 (UTC) FILETIME=[D54D2B60:01C25844]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> On Mon, 2002-09-09 at 09:15, David S. Miller wrote:
> > Note that Andrew Morton found the problem on one of his older
> > x86 EGCS's about the same time I found it on sparc64.
> 
> egcs gets so many long long things wrong on x86 that its only valid use
> IMHO for 2.5 is as a syntax checker. Is it really worth an ugly hack for
> a compiler one major developer has a personal affliction for and a port
> that has a tiny user base and now has a working compiler.
> 
> Maybe if we put less gunk in the kernel they'd fix gcc more often 8)

Please.  I'm not a reason for hanging onto egcs-1.1.2; and I'll
downgrade to 2.95.2 when egcs-1.1.2 is retired (as I did a while back).

But as long as we need to support 1.1.2, I use it.  To detect
breakage, and because it compiles kernels 30% faster.
