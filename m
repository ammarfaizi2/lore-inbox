Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261510AbTCGK7A>; Fri, 7 Mar 2003 05:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261504AbTCGK6p>; Fri, 7 Mar 2003 05:58:45 -0500
Received: from [195.39.17.254] ([195.39.17.254]:7428 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261510AbTCGK60>;
	Fri, 7 Mar 2003 05:58:26 -0500
Date: Thu, 6 Mar 2003 17:18:53 +0100
From: Pavel Machek <pavel@suse.cz>
To: Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <20030306161853.GD2781@zaurus.ucw.cz>
References: <200303020011.QAA13450@adam.yggdrasil.com> <20030301202617.A18142@kerberos.ncsl.nist.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030301202617.A18142@kerberos.ncsl.nist.gov>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> But anyway, what made[1] Bitkeeper suck less is the real DAG
> structure.  Neither arch nor subversion seem to have understood that
> and, as a result, don't and won't provide the same level of semantics.
> Zero hope for Linus to use them, ever.  They're needed for any
> decently distributed development process.

Can you elaborate? I thought that this
"real DAG" structure is more or less
equivalent to each developer having
his owm CVS repository...

> Hell, arch is still at the update-before-commit level.  I'd have hoped
> PRCS would have cured that particular sickness in SCM design ages ago.
> 
> Atomicity, symbolic links, file renames, splits (copy) and merges (the
> different files suddendly ending up being the same one) are somewhat
> important, but not the interesting part.  A good distributed DAG
> structure and a quality 3-point version "merge" is what you actually
> need to build bk-level SCMs.

If I fixed CVS renames, added atomic
commits, splits and merges, and gave each
developer his own CVS repository,
would I be in same league as bk?
Ie 10 times slower but equivalent
functionality?

(3 point merge should be doable for CVS
to and would be good thing anyway,
right?)
				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

