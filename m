Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbTI0S1m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 14:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbTI0S1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 14:27:42 -0400
Received: from mail4.bluewin.ch ([195.186.4.74]:54458 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S262149AbTI0S1l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 14:27:41 -0400
Date: Sat, 27 Sep 2003 20:27:30 +0200
From: Roger Luethi <rl@hellgate.ch>
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] No Swap. Re: [BUG 2.6.90-test5] kernel shits itself with 48mb ram under moderate load
Message-ID: <20030927182730.GA5315@k3.hellgate.ch>
Mail-Followup-To: Ihar 'Philips' Filipau <filia@softhome.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Apl1.4ur.9@gated-at.bofh.it> <Ar3B.6UW.21@gated-at.bofh.it> <3F75D35C.9040609@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F75D35C.9040609@softhome.net>
X-Operating-System: Linux 2.6.0-test5 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Sep 2003 20:13:48 +0200, Ihar 'Philips' Filipau wrote:
> Roger Luethi wrote:
> >On Sun, 28 Sep 2003 01:26:34 +1000, Jason Lewis wrote:
> >>0 12      0   3424    816   6008    0    0 19712     0 5519  3184  0 12  
> >>0 87
> >
> >          ^^^^
> >Looks like you don't have swap enabled. Are successful 2.4 runs with or
> >without swap?
> >
> 
>    I'm running RH stock 2.4.20-20.9 without swap for around month.
>    OOo, Mozilla, eDonkey & heaps of xterms. Even evaluation of VMware 
> with Win2K inside was Ok.
>    On average: much better experience.

Better than with swap? Or better than 2.6?

> $ free
>              total       used       free     shared    buffers     cached
> Mem:        513872     507128       6744          0      32784     341404

The initial post was about a 48 MB machine. 10% of what you have. The
poster's system is paging like crazy -- since all dirty pages without a
mapping are pinned in memory, it must shuffle around the rest.

Roger
