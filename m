Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbVAMDBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbVAMDBR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 22:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbVAMDBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 22:01:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:43998 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261414AbVAMDBK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 22:01:10 -0500
Date: Wed, 12 Jan 2005 19:01:09 -0800
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, davej@redhat.com,
       marcelo.tosatti@cyclades.com, greg@kroah.com, chrisw@osdl.org,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
Message-ID: <20050112190109.X469@build.pdx.osdl.net>
References: <20050112094807.K24171@build.pdx.osdl.net> <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050112185133.GA10687@kroah.com> <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112205350.GM24518@redhat.com> <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org> <20050112182838.2aa7eec2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050112182838.2aa7eec2.akpm@osdl.org>; from akpm@osdl.org on Wed, Jan 12, 2005 at 06:28:38PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> AFAIUI, the vendor requirement is that they have time to have an upgraded
> kernel package on their servers when the bug becomes public knowledge.

Yup.

> If correct and reasonable, then what is the best way in which we can
> support them in this while promptly upgrading the kernel.org kernel?

Most projects inform vendors with enough heads-up time to let them get
their stuff together and out the door.

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

No, that's pretty similar to CVE allocation.  At one time, there was
little effort even put into allocating CVE entries for local DoS holes.
It's not that they aren't important, but less critical than remote DoS
issues, and way less so than anything priv escalation related.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
