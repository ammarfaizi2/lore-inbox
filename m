Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261750AbVASPji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbVASPji (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 10:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbVASPje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 10:39:34 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:37611 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261750AbVASPjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 10:39:23 -0500
Date: Wed, 19 Jan 2005 13:56:18 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
Message-ID: <20050119125618.GA476@openzaurus.ucw.cz>
References: <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050112185133.GA10687@kroah.com> <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112205350.GM24518@redhat.com> <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org> <20050112182838.2aa7eec2.akpm@osdl.org> <20050113033542.GC1212@redhat.com> <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > For us thankfully, exec-shield has trapped quite a few remotely
> > exploitable holes, preventing the above.
> 
> One thing worth considering, but may be abit _too_ draconian, is a
> capability that says "can execute ELF binaries that you can write to".
> 
> Without that capability set, you can only execute binaries that you cannot
> write to, and that you cannot _get_ write permission to (ie you can't be
> the owner of them either - possibly only binaries where the owner is
> root).

Well, if there's gdb installed on such machine, you can probably circumvent this.

Hmm, you can probably do /lib/ld-linux.so.2 your binary, no?
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

