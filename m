Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261723AbTCGS6P>; Fri, 7 Mar 2003 13:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261727AbTCGS6P>; Fri, 7 Mar 2003 13:58:15 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:34573 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S261723AbTCGS6O>; Fri, 7 Mar 2003 13:58:14 -0500
Date: Fri, 7 Mar 2003 20:08:48 +0100
From: Pavel Machek <pavel@suse.cz>
To: Olivier Galibert <galibert@pobox.com>, Pavel Machek <pavel@suse.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <20030307190848.GB21023@atrey.karlin.mff.cuni.cz>
References: <200303020011.QAA13450@adam.yggdrasil.com> <20030301202617.A18142@kerberos.ncsl.nist.gov> <20030306161853.GD2781@zaurus.ucw.cz> <20030307121215.GA68353@dspnet.fr.eu.org> <20030307123237.GG18420@atrey.karlin.mff.cuni.cz> <20030307165413.GA78966@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030307165413.GA78966@dspnet.fr.eu.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Now if the development went that way:
> 
> 1.7  -> 1.7.1.1 (branching, i.e. copy)
>  v         v
>  v      1.7.1.2
> 1.8        v
>  v   -> 1.7.1.3 (merge)
> 1.9        v
>  v         v
> 1.10       v
>  v   -> 1.7.1.4 (merge)
>  v         v
>  v      1.7.1.5
>  v         v
> 1.11 <-         (merge)
> 
> Pretty much standard, a developper created a new branch, made some
> changes in it, synced with mainline, synced with mailine again a
> little later, made some new changes and finally folded the branch back
> in the mainline.  Let's admit the developper changes don't conflict by
> themselves with the mainline changes.
> 
> CVS, for all the merges, is going to pick 1.7 as the reference.  The
> first time, for 1.7.1.3, it's going to work correctly.  It will fuse
> the 1.7->1.8 patch with the 1.7.1.1->1.7.1.2 patch and apply the
> result to 1.7 to get 1.7.1.3.  The two patches have no reason to
> overlap.  1.7.1.2->1.7.1.3 will essentially be identical to
> 1.7->1.8,

So, basically, if branch was killed and recreated after each merge
from mainline, problem would be solved, right?

							Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
