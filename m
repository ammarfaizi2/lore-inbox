Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281017AbRK3U3C>; Fri, 30 Nov 2001 15:29:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283718AbRK3U2w>; Fri, 30 Nov 2001 15:28:52 -0500
Received: from cx570538-a.elcjn1.sdca.home.com ([24.5.14.144]:45700 "EHLO
	keroon.dmz.dreampark.com") by vger.kernel.org with ESMTP
	id <S281017AbRK3U2h>; Fri, 30 Nov 2001 15:28:37 -0500
Message-ID: <3C07EBB9.CF5EB85E@randomlogic.com>
Date: Fri, 30 Nov 2001 12:27:37 -0800
From: "Paul G. Allen" <pgallen@randomlogic.com>
Organization: Akamai Technologies, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Coding style - a non-issue
In-Reply-To: <OF8451D8AC.A8591425-ON4A256B12.00806245@au.ibm.com> <Pine.GSO.4.21.0111281901110.8609-100000@weyl.math.psu.edu> <20011128162317.B23210@work.bitmover.com> <9u7lb0$8t9$1@forge.intermeta.de> <20011130072634.E14710@work.bitmover.com> <1007138360.6656.27.camel@forge> <3C07B820.4108246F@mandrakesoft.com> <20011130185359.Q31176@blu> <3C07CDFB.7F1A9FFC@randomlogic.com> <3C07D742.A62FF72E@mandrakesoft.com> <20011130144112.A31385@tux.gsfc.nasa.gov>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Kodis wrote:
> 
> On Fri, Nov 30, 2001 at 02:00:18PM -0500, Jeff Garzik wrote:
> 
> > Human beings know and understand context, and can use it
> > effectively.  'idx' or 'i' or 'bh' may make perfect sense in
> > context.  There is absolutely no need for
> > JournalBHThatIsStoredAndSyncedWithSuperblock.

JounalBH would be far better than i or idx.

> 
> Mathematics has a rich tradition of using short variable names such as
> "pi" rather than something like "circle-circumference-to-diameter-ratio".
> They keep formulas from becoming unreadably long, and have a meaning
> which is well understood in context.  While the long version may more
> self-explainatory, it's the short form which is universally preferred.
> 

While 'pi', 'e', 'theta', 'phi', etc. are universally understood, things
like 'i', 'a', and 'idx' are not. I can use these for anything I want
and even for more than one thing, and they say nothing about what they
are for. 'i', 'j', etc. are fine as loop counters and array indexes
where their meaning is apparent by context, but are _not_ fine in other
situations. You (or the person that wrote the code) may think that the
name is perfectly fine, but someone else that thinks a bit different may
not.

PGA
-- 
Paul G. Allen
UNIX Admin II ('til Dec. 3)/FlUnKy At LaRgE (forever!)
Akamai Technologies, Inc.
www.akamai.com
