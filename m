Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262651AbREVQyE>; Tue, 22 May 2001 12:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262643AbREVQxy>; Tue, 22 May 2001 12:53:54 -0400
Received: from waste.org ([209.173.204.2]:17177 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S262651AbREVQxj>;
	Tue, 22 May 2001 12:53:39 -0400
Date: Tue, 22 May 2001 11:54:55 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Theodore Tso <tytso@valinux.com>, Andrew McNamara <andrewm@connect.com.au>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Ext2, fsync() and MTA's?
In-Reply-To: <20010522174825.Q8080@redhat.com>
Message-ID: <Pine.LNX.4.30.0105221152400.19818-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 May 2001, Stephen C. Tweedie wrote:

> On Tue, May 22, 2001 at 10:50:51AM -0500, Oliver Xymoron wrote:
> > On Mon, 21 May 2001, Theodore Tso wrote:
> >
> > > On Mon, May 21, 2001 at 06:47:58PM +0100, Stephen C. Tweedie wrote:
> > >
> > > > Just set chattr +S on the spool dir.  That's what the flag is for.
> > > > The biggest problem with that is that it propagates to subdirectories
> > > > and files --- would a version of the flag which applied only to
> > > > directories be a help here?
> > >
> > > That's probably the right thing to add.
> >
> > I'd vote for an async flag instead.
>
> Why???  Why change the default behaviour to be something much slower?

I was suggesting an async flag _in addition_ to the sync flag, both
propagating to subdirs. Nice and orthogonal.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

