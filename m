Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132255AbQK0CRA>; Sun, 26 Nov 2000 21:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132444AbQK0CQu>; Sun, 26 Nov 2000 21:16:50 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:56848 "EHLO
        vger.timpanogas.org") by vger.kernel.org with ESMTP
        id <S132255AbQK0CQd>; Sun, 26 Nov 2000 21:16:33 -0500
Date: Sun, 26 Nov 2000 19:43:14 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] modutils 2.3.20 and beyond
Message-ID: <20001126194314.B2265@vger.timpanogas.org>
In-Reply-To: <20001126163655.A1637@vger.timpanogas.org> <1604.975280988@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <1604.975280988@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Mon, Nov 27, 2000 at 10:23:08AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2000 at 10:23:08AM +1100, Keith Owens wrote:
> On Sun, 26 Nov 2000 16:36:55 -0700, 
> "Jeff V. Merkey" <jmerkey@vger.timpanogas.org> wrote:
> >Keith,
> >
> >Please consider the attached patch for inclusion in all future versions
> >of the modutils depmod program for compatiblity with RedHat and 
> >RedHat derived Linux distributions.
> 
> I have a big problem with Redhat.  They make incompatible changes to
> utilities, do not feed patches back to maintainers then expect the rest
> of the world to follow their lead.  The -i and -m flags to modutils are
> not the only example, I recently found IA64 and Sparc patches they had
> added to modutils code and not bothered to tell me.  Other distributors
> are much better about sending me patches, Debian and SuSe in particular
> do the right thing.
> 
> Since "-F System.map" in modutils is equivalent to "-m System.map -i"
> and works on all distributions, not just Redhat, the "-m -i" patch is
> unnecessary.  Consider this my protest against bad habits by
> distributors, they created the mess with their lack of communication
> and they have to fix it.

Well Keith, I will never fail to post back changes to you, as evidenced
by the fact I did send you one.  Anconda is open sourced, and as such,
is no longer owned by any distributor.  The question is whether to 
diverge it from theirs.  I would like to not do this, since, as you
point out, it generates changes back the other way.   

It's your call.  I can keep the patch around because I really don't 
want to diverge anaconda any more than I have to.  At some point,
perhaps they will get changes to you more timely.  

:-)

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
