Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751379AbVHVWXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbVHVWXI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbVHVWXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:23:06 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:54152 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751347AbVHVWWx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:22:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Sbv/TD2dvDDwRr2Ntn6tCGB0ihKUBLKblREFl5aLL/M4SBHmxmxRkfwwK4Can371gjDc2K4TuhSPsgA4qHbECddqFKmwFmviWzsjbPwhXoA6XoCrI2wtDfNwsX/sqB6NApJYPklSFJXttt81r+QeZi3yLEy6T02ZrU/fajnwAyE=
Message-ID: <58cb370e0508220228770415f7@mail.gmail.com>
Date: Mon, 22 Aug 2005 11:28:31 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: IT8212/ITE RAID
Cc: Daniel Drake <dsd@gentoo.org>, CaT <cat@zip.com.au>,
       linux-kernel@vger.kernel.org
In-Reply-To: <58cb370e050814142013db4ba1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050814053017.GA27824@zip.com.au> <42FF263A.8080009@gentoo.org>
	 <20050814114733.GB27824@zip.com.au> <42FF3CBA.1030900@gentoo.org>
	 <1124026385.14138.37.camel@localhost.localdomain>
	 <58cb370e050814080120291979@mail.gmail.com>
	 <1124034767.14138.55.camel@localhost.localdomain>
	 <58cb370e050814085613ccc42c@mail.gmail.com>
	 <1124054033.26937.3.camel@localhost.localdomain>
	 <58cb370e050814142013db4ba1@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any news about URLs?  It shouldn't be too hard find them unless they
never existed in the first place. I will work on the issues immediately.

Bartlomiej

On 8/14/05, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> On 8/14/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > On Sul, 2005-08-14 at 17:56 +0200, Bartlomiej Zolnierkiewicz wrote:
> > > * your stuff was accepted after all (and some stuff like ide-cd
> > >   fixes was never splitted from the -ac patchset and submitted)
> >
> > They were.
> 
> I remember discussion about end-of-media ide-cd fixes but the patch
> was never submitted.  If you have *URL* to the patch I'll work on the patch.
> 
> > > * you've never provided any technical details on "the stuff I broke"
> >
> > I did, several times. I had some detailed locking discussions with
> > Manfred and others on it as a result. The locking in the base IDE is
> > still broken, in fact its become worse - the random locking around
> > timing changes now causes some PIIX users to see double spinlock debug
> > with the base kernel as an example.
> 
> Huh?  *WHICH* my patch causes this?
> 
> I don't remember this discussion et all, care to give some pointers?
> 
> > > > Would make sense, but I thought I had the right bits masked. Will take a
> > >
> > > WIN_RESTORE is send unconditionally (as it always was),
> > >
> > > This is not the right thing, somebody should go over all ATA/ATAPI
> > > drafts and come with the correct strategy of handling WIN_RESTORE.
> >
> > Ok that would make sense. Matthew Garrett also reported some problems in
> > that area with suspend/resume (BIOS restoring its idea of things...)
> 
> Quite likely, WIN_RESTORE is not sent on resume etc.
>
