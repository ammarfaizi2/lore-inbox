Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312719AbSCVVBC>; Fri, 22 Mar 2002 16:01:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312844AbSCVVAn>; Fri, 22 Mar 2002 16:00:43 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:17796 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S312719AbSCVVAl>; Fri, 22 Mar 2002 16:00:41 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 22 Mar 2002 13:05:39 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Matti Aarnio <matti.aarnio@zmailer.org>
cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ORBZ is dead, don't use it...
In-Reply-To: <20020322225305.B27741@mea-ext.zmailer.org>
Message-ID: <Pine.LNX.4.44.0203221303400.1434-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2002, Matti Aarnio wrote:

> On Fri, Mar 22, 2002 at 01:45:36PM -0700, Richard Gooch wrote:
> > Matti Aarnio writes:
> > > We have been dropping people because they use now dead ORBZ:
> > >
> > >     Rejected - see http://orbz.org/
> > >
> > > The problem with these DNS-RBL things is that they are subject to
> > > all kinds of external pressures, and apparently ORBZ has followed
> > > ORBS in this manner.
> >
> > Interesting. When I try to lookup hosts using orbz.org, I just get
> > Non-existent host/domain results (thus mail shouldn't bounce). Why are
> > some people bouncing email?
>
>   I see both DNS lookup timeouts, and SERVFAIL returns.
>   In my books neither should lead to rejection, but
>   a) others may have better wisdom that I have,
>   b) some popular software are known to be unable to
>      separate any sort of temporary failures (timeouts
>      at DNS lookup) from real things (actual DNS-RBL)

Only positive lookups should lead to rejection, IMHO. Timeouts & Co.
should default to acception.




- Davide


