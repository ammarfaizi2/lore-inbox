Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbVAMC4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVAMC4a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 21:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbVAMC4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 21:56:30 -0500
Received: from mail.kroah.org ([69.55.234.183]:57992 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261366AbVAMC4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 21:56:16 -0500
Date: Wed, 12 Jan 2005 18:56:06 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, davej@redhat.com,
       marcelo.tosatti@cyclades.com, chrisw@osdl.org, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
Message-ID: <20050113025606.GB16910@kroah.com>
References: <20050112094807.K24171@build.pdx.osdl.net> <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050112185133.GA10687@kroah.com> <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112205350.GM24518@redhat.com> <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org> <20050112182838.2aa7eec2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112182838.2aa7eec2.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 06:28:38PM -0800, Andrew Morton wrote:
> 
> IMO, local DoS holes are important mainly because buggy userspace
> applications allow remote users to get in and exploit them, and for that
> reason we of course need to fix them up.  Even though such an attacker
> could cripple the machine without exploiting such a hole.
> 
> For the above reasons I see no need to delay publication of local DoS holes
> at all.  The only thing for which we need to provide special processing is
> privilege escalation bugs.
> 
> Or am I missing something?

So, a "classification" of the severity of the bug would cause different
type of disclosures?  That's a good idea in theory, but trying to nail
down specific for bug classifications tends to be difficult.

Although I think both Red Hat and SuSE have a classification system in
place already that might help out here.

Anyway, if so, I like it.  I think that would be a good thing to have,
if for no other reason that I don't want to see security announcements
for every single driver bug that's patched that had caused a user
created oops.

thanks,

greg k-h
