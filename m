Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263955AbTCWW1g>; Sun, 23 Mar 2003 17:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263956AbTCWW1g>; Sun, 23 Mar 2003 17:27:36 -0500
Received: from franka.aracnet.com ([216.99.193.44]:2745 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263955AbTCWW1e>; Sun, 23 Mar 2003 17:27:34 -0500
Date: Sun, 23 Mar 2003 14:38:24 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Robert Love <rml@tech9.net>, Martin Mares <mj@ucw.cz>,
       Alan Cox <alan@redhat.com>, Stephan von Krawczynski <skraw@ithnet.com>,
       Pavel Machek <pavel@ucw.cz>, szepe@pinerecords.com, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: Ptrace hole / Linux 2.2.25
Message-ID: <29100000.1048459104@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I see a lot of new Red Hat work getting discussed, landing in the 2.5
> tree, and then getting backported as a value-add 2.4 feature for an RH
> kernel.  Other stuff is "hack it into stability, but it's ugly and should
> not go to Marcelo."
> 
> IMNSHO this perception is more a not-looking-hard-enough issue rather
> than reality.

Well ... or we had different meanings ;-) yes, lots of stuff is in 2.5
but I was meaning 2.4. If there's stuff that's in both RH and UL kernels,
and it's stable enough for them both to ship as their product, it sounds
mergeable to me.

> I have no idea about UnitedLinux kernel, but for RHAS I wager there is
> next to _nil_ patches you would actually want to submit to Marcelo, for
> three main reasons:  it's a 2.5 backport, or, it's a 2.4.2X backport, or,
> its an ugly-hack-for-stability that should not be in a mainline kernel
> without cleaning anyway.

I don't see what's wrong with putting 2.5 backports into 2.4 once they're
stable. And I'd rather have an ugly-hack-for-stability than an unstable
kernel ... 2.5 is the place for cleanliness ... 2.4 is a dead end that
just needs to work.

> Can you actually quantify this divergance?
> 
>  From actually _looking_ at RHAS for submittable patches, it seems to me
> like mostly 2.5-backport patches in 2.4, or, bandaid-until-2.5 fixes that
> don't belong in mainline.

Right ... I think we're agreeing about what's the difference. Just
disagreeing about what should be in mainline 2.4. If most others think it
shouldn't go either, than I guess we need a separate tree for a 2.4 that
works, not a 2.4 that's pretty ...

M.

