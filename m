Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262506AbTCMQqJ>; Thu, 13 Mar 2003 11:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262508AbTCMQqJ>; Thu, 13 Mar 2003 11:46:09 -0500
Received: from mx12.arcor-online.net ([151.189.8.88]:47532 "EHLO
	mx12.arcor-online.net") by vger.kernel.org with ESMTP
	id <S262506AbTCMQqH>; Thu, 13 Mar 2003 11:46:07 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Date: Thu, 13 Mar 2003 18:00:48 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Zack Brown <zbrown@tumblerings.org>, linux-kernel@vger.kernel.org
References: <200303130052.h2D0qFFT001062@eeyore.valparaiso.cl>
In-Reply-To: <200303130052.h2D0qFFT001062@eeyore.valparaiso.cl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030313165652.7CF10109CC9@mx12.arcor-online.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 13 Mar 03 01:52, Horst von Brand wrote:
> Daniel Phillips <phillips@arcor.de> said:
> > On Wed 12 Mar 03 04:47, Horst von Brand wrote:
> > > ...You need to focus on changes to files,
> > > not files. I.e., file appeared/dissapeared/changed name/was edited by
> > > altering lines so and so.
> >
> > It's useful to make the distinction that "file
> > appeared/dissapeared/changed name" are changes to a directory object,
> > while "was edited by altering lines so and so" is a change to a file
> > object...
>
> I don't think so. As the user sees it, a directory is mostly a convenient
> labeled container for files. You think in terms of moving files around, not
> destroying one and magically creating an exact copy elsewhere (even if
> mv(1) does exactly this in some cases). Also, this breaks up the operation
> "mv foo bar/baz" into _two_ changes, and this is wrong as the file loses
> its revision history.

No, that's a single change to one directory object.

> > ...then this part gets much easier.
>
> ... by screwing it up. This is exactly one of the problems noted for CVS.

CVS doesn't have directory objects.

Does anybody have a convenient mailing list for this design discussion?

Regards,

Daniel
