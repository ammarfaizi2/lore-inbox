Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbUKSNje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbUKSNje (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 08:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbUKSNje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 08:39:34 -0500
Received: from zxa8020.lanisdn-gte.net ([206.46.31.146]:17358 "EHLO
	links.magenta.com") by vger.kernel.org with ESMTP id S261410AbUKSNgA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 08:36:00 -0500
Date: Fri, 19 Nov 2004 08:35:17 -0500
From: Raul Miller <moth@magenta.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-os@analogic.com, Andi Kleen <ak@suse.de>,
       David Woodhouse <dwmw2@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: RFC: let x86_64 no longer define X86
Message-ID: <20041119083517.A22958@links.magenta.com>
References: <20041119103418.GB30441@wotan.suse.de> <1100863700.21273.374.camel@baythorne.infradead.org> <20041119115539.GC21483@wotan.suse.de> <1100865050.21273.376.camel@baythorne.infradead.org> <20041119120549.GD21483@wotan.suse.de> <419DE33E.2000208@pobox.com> <20041119121909.GF21483@wotan.suse.de> <419DE90D.9030509@pobox.com> <Pine.LNX.4.61.0411190749170.12075@chaos.analogic.com> <419DEF79.2090309@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <419DEF79.2090309@pobox.com>; from jgarzik@pobox.com on Fri, Nov 19, 2004 at 08:04:57AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> linux-os wrote:
> > Why CONFIG_ISA_BROKEN. That implies (states) that its broken and

On Fri, Nov 19, 2004 at 08:04:57AM -0500, Jeff Garzik wrote:
> The name is appropriate because the drivers in question _are_ broken.

On some architectures -- this is a porting issue, and not a clean binary
distinction.

ASSUMES_32_BIT or some other "32 bit" name would probably better capture
this particular issue.

Even better might be to get the compiler to catch the most obvious
mistakes and use #define decorations to override the compiler's
determination (you'd need two of these, because the compiler can get
this wrong in two different ways).

-- 
Raul
