Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273305AbRJIJpj>; Tue, 9 Oct 2001 05:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273896AbRJIJpa>; Tue, 9 Oct 2001 05:45:30 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:21522 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S273305AbRJIJpT>; Tue, 9 Oct 2001 05:45:19 -0400
Date: Tue, 9 Oct 2001 11:45:48 +0200
From: Pavel Machek <pavel@suse.cz>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: %u-order allocation failed
Message-ID: <20011009114548.A3341@atrey.karlin.mff.cuni.cz>
In-Reply-To: <E15qk40-0002Jf-00@the-village.bc.nu> <Pine.LNX.3.96.1011009014458.15573A-100000@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1011009014458.15573A-100000@artax.karlin.mff.cuni.cz>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Linus, what do you think: is it OK if fork randomly fails with very small
> > > probability or not?
> > 
> > Your code doesnt change that behaviour. Not one iota. Do the mathematics,
> > work out the failure probabilities for page pairs. Now remember that the
> > vmalloc one has guard pages too.
> > 
> > You are trying to solve a non problem with a non solution
> 
> I asked Linus, not you :-/
> 
> It's up to him, if he wants "stability-based-on-probability" algorithms in
> Linux or not.

You ignored comment about guard pages.
									Pavel
-- 
Casualities in World Trade Center: 6453 dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
