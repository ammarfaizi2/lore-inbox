Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261792AbVCHGfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbVCHGfo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 01:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbVCHGfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 01:35:43 -0500
Received: from waste.org ([216.27.176.166]:22190 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261792AbVCHGeU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 01:34:20 -0500
Date: Mon, 7 Mar 2005 22:33:44 -0800
From: Matt Mackall <mpm@selenic.com>
To: "Jack O'Quin" <joq@io.com>
Cc: Andrew Morton <akpm@osdl.org>, paul@linuxaudiosystems.com,
       cfriesen@nortelnetworks.com, chrisw@osdl.org, hch@infradead.org,
       rlrevell@joe-job.com, arjanv@redhat.com, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050308063344.GM3120@waste.org>
References: <20050112185258.GG2940@waste.org> <200501122116.j0CLGK3K022477@localhost.localdomain> <20050307195020.510a1ceb.akpm@osdl.org> <20050308043349.GG3120@waste.org> <20050307204044.23e34019.akpm@osdl.org> <87acpesnzi.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87acpesnzi.fsf@sulphur.joq.us>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 11:30:57PM -0600, Jack O'Quin wrote:
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

I wouldn't say "likely". But anything's possible, so I wouldn't rule
it out entirely.
 
> 2. requires updates to all the shells

Requires update to the PAM distro for our purposes. 

> 3. forces Windows and Mac musicians to learn and understand PAM

Or for the distro (ubuntu or whatever) to catch up. The alternative is
for the user to compile their own kernel module and mess with its
arcane interface.

> 4. is undocumented and has never been tested in any real music studios

Well you'll have a bit to test it before it goes to Linus.

-- 
Mathematics is the supreme nostalgia of our time.
