Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131077AbQLVV2F>; Fri, 22 Dec 2000 16:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131118AbQLVV1z>; Fri, 22 Dec 2000 16:27:55 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:61189 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131077AbQLVV1s>; Fri, 22 Dec 2000 16:27:48 -0500
Date: Fri, 22 Dec 2000 14:52:26 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pauline Middelink <middelin@polyware.nl>, linux-kernel@vger.kernel.org,
        jmerkey@timpanogas.org
Subject: Re: NUMA and SCI [was Re: bigphysarea support in 2.2.19 and 2.4.0 kernels]
Message-ID: <20001222145226.A2025@vger.timpanogas.org>
In-Reply-To: <20001222133908.A1686@vger.timpanogas.org> <E149YpM-0005A2-00@the-village.bc.nu> <20001222144059.A1946@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001222144059.A1946@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Fri, Dec 22, 2000 at 02:40:59PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2000 at 02:40:59PM -0700, Jeff V. Merkey wrote:
> On Fri, Dec 22, 2000 at 08:30:07PM +0000, Alan Cox wrote:
> > > I think we do need some bettr APIs.  Grab the source at my FTP server,
> > > and I'd love any input you could provide.
> > 
> > Pure message passing drivers for the Dolphinics cards already exist. Ron
> > Minnich wrote some.
> > 
> > http://www.acl.lanl.gov/~rminnich/
> > 
> > Alan
> 
> Not for the newer cards.  I will look over his code, and see what's there.
> 
> Jeff
>

Alan,

I reviewed his code.  It's only current as of 2.2.5 and guess what?  It also
requires the bigphysarea patch.  The code I am using includes support for
all the versions of the Dolphin SCI cards, so it is larger than what's
there, but his versions are heavily dependent on this patch as well.

Jeff

 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
