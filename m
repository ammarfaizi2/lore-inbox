Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbVJRGVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbVJRGVE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 02:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbVJRGVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 02:21:03 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:17140 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932409AbVJRGVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 02:21:02 -0400
Date: Tue, 18 Oct 2005 02:20:38 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Matt Mackall <mpm@selenic.com>
cc: linux-kernel@vger.kernel.org, Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Esben Nielsen <simlo@phys.au.dk>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: ketchup+rt with ktimers added.
In-Reply-To: <20051017213915.GN26160@waste.org>
Message-ID: <Pine.LNX.4.58.0510180211320.13581@localhost.localdomain>
References: <Pine.LNX.4.58.0510170316310.5859@localhost.localdomain>
 <20051017213915.GN26160@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Oct 2005, Matt Mackall wrote:

> On Mon, Oct 17, 2005 at 03:38:49AM -0400, Steven Rostedt wrote:
> >

>
> Thomas has indicated that these trees might not be very long-lived. So
> instead, I've added the ability to make local extensions:
>
> .ketchuprc:
>
> local_trees = {
>     '2.6-kt': (latest_dir,
>                "http://www.tglx.de/projects/ktimers/patch-%(full)s.patch",
>                r'patch-(2.6.*?)',
>                0, "Thomas Gleixner's ktimers."),
>     '2.6-kthrt': (latest_dir,
>                   "http://www.tglx.de/projects/ktimers/patch-%(full)s.patch",
>                   r'patch-(2.6.*?)',
>                   0, "Thomas Gleixner's ktimers and HRT patches.")
>     }
>
> $ ./ketchup -s 2.6-kt
> 2.6.14-rc4-kthrt3.patch

I did not know about this extension.  Good to know, thanks.

>
> > Since the base version of Michal Schmidt's ketchup-0.9+rt didn't include
> > Esben Nielsen's addition of handling Ingo's older kernels, I again
> > included it with this patch.
>
> That's been in tip for a while:
>
> http://selenic.com/repo/ketchup/
>

I didn't know about your repo directory.  Sorry, didn't have time to look
too deep into this. I just did a few searches on the web and found
different links scattered around.  I was just interested in the RT stuff,
so I didn't go to deep.

Actually, if you had a link to the repo from
http://www.selenic.com/ketchup/ I would have found it.

Thanks for the info, and hopefully this will now be public enough so other
thick headed people (like myself :-) knows about the local extensions.

Cheers,

-- Steve

