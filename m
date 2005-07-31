Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbVGaDxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVGaDxo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 23:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVGaDxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 23:53:44 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:47494 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261603AbVGaDxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 23:53:43 -0400
Date: Sat, 30 Jul 2005 22:53:21 -0500
From: serge@hallyn.com
To: Tony Jones <tonyj@suse.de>
Cc: serue@us.ibm.com, lkml <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>, steve@immunix.com
Subject: Re: [patch 0/15] lsm stacking v0.3: intro
Message-ID: <20050731035321.GA17154@vino.hallyn.com>
References: <20050727181732.GA22483@serge.austin.ibm.com> <20050730050701.GA22901@immunix.com> <20050730190222.GA12473@vino.hallyn.com> <20050730201852.GA8223@immunix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050730201852.GA8223@immunix.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tony Jones (tonyj@suse.de):
> > Yes, after I added the unlink function, it started to seem that the
> > special cases for !CONFIG_SECURITY_STACKER wouldn't be any faster than
> > the stacker versions.  They still might be, but I'll have to think about
> > it.  If I just ditch those, then I can probably ditch the whole
> 
> Esp since James' suggestion would impact it. I'd imagine you would always want
> array[0] for this case, no?

Actually I don't think that's even needed - I just wasn't thinking right
while addressing another bug.

thanks,
-serge
