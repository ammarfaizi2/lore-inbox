Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289096AbSANWbY>; Mon, 14 Jan 2002 17:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289108AbSANWbK>; Mon, 14 Jan 2002 17:31:10 -0500
Received: from femail48.sdc1.sfba.home.com ([24.254.60.42]:27794 "EHLO
	femail48.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S289120AbSANWan>; Mon, 14 Jan 2002 17:30:43 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: esr@thyrsus.com, Charles Cazabon <charlesc@discworld.dyndns.org>
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
Date: Mon, 14 Jan 2002 09:28:41 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Eli Carter <eli.carter@inet.com>,
        "Michael Lazarou (ETL)" <Michael.Lazarou@etl.ericsson.se>
In-Reply-To: <20020114125228.B14747@thyrsus.com> <20020114125508.A3358@twoflower.internal.do> <20020114135412.D17522@thyrsus.com>
In-Reply-To: <20020114135412.D17522@thyrsus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020114223042.ENDG28486.femail48.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 January 2002 01:54 pm, Eric S. Raymond wrote:
> Charles Cazabon <charlesc@discworld.dyndns.org>:
> > Yes, and yes.  Aunt Tillie is running Linux because someone installed a
> > distribution for her.
>
> You don't know that.  Maybe she installed it herself.
>
> > She is never going to need anything out of her kernel that her
> > vendor-shipped update kernels do not provide.
>
> *You can't know that.*
>
> And your belief that you *can* know it is a key part of the elitist
> developer psychology and implicit assumptions that keeps Linux mostly
> inaccessible to the Aunt Tillies of the world.

No need to get defensive, Eric.

If make autoprobe is to become useful to an aunt tillie, it's something the 
distribution is going to have to provide a wrapper for, which strikes me as 
unlikely in the short term.  (QA issues: there's 8 zillion oddball hardware 
combos out there, and autodetect is guaranteed to either miss something or 
configure something wrong on at least some of them.  It'll need rather a lot 
of shakedown.  More than a year in mainstream.)

As for aunt tillie moving from red hat's kernel to linus's most recent 
kernel, is that advisable?  Vendors provide outside patches long before linus 
does (yes, Linus is more conservative than the distributions are).  And 
sometimes you get brown paper bag releases (2.4.11-dontuse).  Even the 
non-brown-paper-bag ones tend to have hardware combinations that won't build 
due to easily patchable compilation errors, which aunt tillie ain't up to.

A vendor that provides faster updates than Red Hat (like Kevin's Red Hat Uber 
Distribution) is a market opportunity.  But a tool is not the same thing as a 
service.  It just makes providing the service easier.

Make autoconfigure expands the pool of people who can build kernels, but it's 
not going to saturate the populace to the point where everybody immediately 
SHOULD.  Not even close.  Over time, the pool will grow.  But aiming for Aunt 
Tillie in the short term is probably overreaching.

Rob
