Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130392AbQLHWwJ>; Fri, 8 Dec 2000 17:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131163AbQLHWv7>; Fri, 8 Dec 2000 17:51:59 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:43273 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130392AbQLHWvt>; Fri, 8 Dec 2000 17:51:49 -0500
Date: Fri, 8 Dec 2000 16:16:45 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Mark Vojkovich <mvojkovich@valinux.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Andi Kleen <ak@suse.de>,
        Rainer Mager <rmager@vgkk.com>, linux-kernel@vger.kernel.org
Subject: Re: Signal 11
Message-ID: <20001208161645.A6075@vger.timpanogas.org>
In-Reply-To: <25692.976268767@redhat.com> <Pine.LNX.4.30.0012081129140.6704-100000@beefcake.hdqt.valinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.30.0012081129140.6704-100000@beefcake.hdqt.valinux.com>; from mvojkovich@valinux.com on Fri, Dec 08, 2000 at 11:34:51AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2000 at 11:34:51AM -0800, Mark Vojkovich wrote:
> 
> 
> On Fri, 8 Dec 2000, David Woodhouse wrote:
> 
>    Some additional data points.  It goes away on UP 2.4 kernels.
> Also, I can't recall seeing this problem on IA64.  Maybe it's still
> there on IA64 and I just haven't been trying hard enough to crash
> it, but my current impression is that the problem doesn't exist on IA64.
> 
>   Hmmm...  IA64 is a static server.  I don't hear of people having
> problems on 3.3.6 servers either.  I'm wondering if a non-loader
> 4.0 server would have problems on IA32 with a 2.4 kernel.  That's
> something for people to try.
> 
> 
> 				Mark.


I have not seen it on UP systems either.  I only see it on SMP systems.  
After trying very hard last night, I was able to get my 4 x PPro system to 
do it with 2.4.0-12.  It seems related to loading in some way.  If you 
have more than two processors, the loading is less since there's more 
processors, and for whatever reason, it makes it harder to produce
whatever race condition is causing it.  I can get it to happen 
pretty easily on a 2 x PII system.

:-)

Jeff



> 
> >
> > --
> > dwmw2
> >
> > ¹ And the BP6 still falls over less frequently than the dual P3 I use at
> > work.
> > ² RH7. Don't start.
> >
> >
> >
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
