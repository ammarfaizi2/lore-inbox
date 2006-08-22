Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750984AbWHVIXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbWHVIXP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 04:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWHVIXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 04:23:15 -0400
Received: from ns2.suse.de ([195.135.220.15]:53957 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750984AbWHVIXP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 04:23:15 -0400
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: boot failure, "DWARF2 unwinder stuck at 0xc0100199"
Date: Tue, 22 Aug 2006 10:22:59 +0200
User-Agent: KMail/1.9.3
Cc: "Andrew Morton" <akpm@osdl.org>, "J. Bruce Fields" <bfields@fieldses.org>,
       linux-kernel@vger.kernel.org, "Randy.Dunlap" <rdunlap@xenotime.net>
References: <20060820013121.GA18401@fieldses.org> <20060821212043.332fdd0f.akpm@osdl.org> <44EAD613.76E4.0078.0@novell.com>
In-Reply-To: <44EAD613.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608221022.59255.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> My understanding of 'for' is that Andi will send to Linus after in the 2.6.19
> merge window.

Yes.

> 
> >Guys, this unwinder change has been quite problematic.  We really cannot
> >let this badness out into 2.6.18 - it degrades our ability to debug every
> >subsystem in the entire kernel.  Would marking it CONFIG_BROKEN get us back
> >to 2.6.17 behaviour?
> 
> I'd prefer pushing into 2.6.18 some of the patches currently scheduled for
> 2.6.19 over marking it CONFIG_BROKEN. But that's clearly not my decision.

Hmm, which patches did you want? I got a double digit number of unwind
related patches already, some of them quite intrusive, and all of them would be clearly
too much. My preference for 2.6.18 would be really only absolutely critical stuff
because I'm paranoid of breaking more.

-Andi
