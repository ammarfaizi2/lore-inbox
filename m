Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263144AbVCJVUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263144AbVCJVUr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 16:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263147AbVCJVUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 16:20:47 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:60366 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263144AbVCJVUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 16:20:40 -0500
Date: Thu, 10 Mar 2005 15:01:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Jack O'Quin" <joq@io.com>
Cc: Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>,
       paul@linuxaudiosystems.com, cfriesen@nortelnetworks.com,
       chrisw@osdl.org, hch@infradead.org, rlrevell@joe-job.com,
       arjanv@redhat.com, mingo@elte.hu, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050310140126.GC632@openzaurus.ucw.cz>
References: <20050112185258.GG2940@waste.org> <200501122116.j0CLGK3K022477@localhost.localdomain> <20050307195020.510a1ceb.akpm@osdl.org> <20050308043349.GG3120@waste.org> <20050307204044.23e34019.akpm@osdl.org> <87acpesnzi.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87acpesnzi.fsf@sulphur.joq.us>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 07-03-05 23:30:57, Jack O'Quin wrote:
> Andrew Morton <akpm@osdl.org> writes:
> 
> > Matt Mackall <mpm@selenic.com> wrote:
> >>
> >> I think Chris Wright's last rlimit patch is more sensible and ready to
> >>  go.
> >
> > I must say that I like rlimits - very straightforward, although somewhat
> > awkward to use from userspace due to shortsighted shell design.
> >
> > Does anyone have serious objections to this approach?
> 
> 1. is likely to introduce multiuser system security holes like the one
> created recently when the mlock() rlimits bug was fixed (DoS attacks)

Default is unchanged and you claim your boxes are single-user-a-time,
anyway.

> 2. requires updates to all the shells

No. Just set it during login.

> 3. forces Windows and Mac musicians to learn and understand PAM

While you force them to mess with security modules. I'd say thats and improvement.
And "understanding PAM" in this case means updating two files, adding one
line to each.
 
> 4. is undocumented and has never been tested in any real music studios

So write the docs and test it.

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

