Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbVFOAl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbVFOAl5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 20:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVFOAl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 20:41:57 -0400
Received: from ns.suse.de ([195.135.220.2]:37006 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261450AbVFOAly (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 20:41:54 -0400
Date: Wed, 15 Jun 2005 02:41:53 +0200
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: christoph <christoph@scalex86.org>, ak@suse.de,
       linux-kernel@vger.kernel.org, shai@scalex86.org
Subject: Re: [PATCH] Move some variables into the "most_readonly" section??
Message-ID: <20050615004153.GX11898@wotan.suse.de>
References: <Pine.LNX.4.62.0506071253020.2850@ScMPusgw> <20050608131839.GP23831@wotan.suse.de> <Pine.LNX.4.62.0506141551350.3676@ScMPusgw> <20050614162354.6aabe57e.akpm@osdl.org> <Pine.LNX.4.62.0506141644160.4099@ScMPusgw> <20050614165818.6f83fa6c.akpm@osdl.org> <Pine.LNX.4.62.0506141704150.4225@ScMPusgw> <20050614171602.12bfa245.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050614171602.12bfa245.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2005 at 05:16:02PM -0700, Andrew Morton wrote:
> christoph <christoph@scalex86.org> wrote:
> >
> > On Tue, 14 Jun 2005, Andrew Morton wrote:
> > 
> > > > Yup that makes the whole thing much more sane. Can we specify multiple 
> > > > attributes to a variable?
> > > Seems OK?
> > 
> > Looks fine. Want a patch against the existing fixes in mm1? So that we 
> > have a whatever-fix-fix-fix-fix-fix-fix-fix?
> 
> Let's see what it looks like.  Two patches please.  One againt the core
> (optimise-storage-of-read-mostly-variables*.patch) and one against the
> users (move-some-more-structures-into-mostly_readonly-and-readonly.patch).

I think it would be better to first still see numbers for
this questionable optimizations.

-Andi
