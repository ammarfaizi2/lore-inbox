Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262649AbREVQtE>; Tue, 22 May 2001 12:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262628AbREVQsy>; Tue, 22 May 2001 12:48:54 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:36116 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262633AbREVQso>; Tue, 22 May 2001 12:48:44 -0400
Date: Tue, 22 May 2001 17:48:25 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Theodore Tso <tytso@valinux.com>, "Stephen C. Tweedie" <sct@redhat.com>,
        Andrew McNamara <andrewm@connect.com.au>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Ext2, fsync() and MTA's?
Message-ID: <20010522174825.Q8080@redhat.com>
In-Reply-To: <20010521180405.D495@think.thunk.org> <Pine.LNX.4.30.0105221045530.19818-100000@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0105221045530.19818-100000@waste.org>; from oxymoron@waste.org on Tue, May 22, 2001 at 10:50:51AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 22, 2001 at 10:50:51AM -0500, Oliver Xymoron wrote:
> On Mon, 21 May 2001, Theodore Tso wrote:
> 
> > On Mon, May 21, 2001 at 06:47:58PM +0100, Stephen C. Tweedie wrote:
> >
> > > Just set chattr +S on the spool dir.  That's what the flag is for.
> > > The biggest problem with that is that it propagates to subdirectories
> > > and files --- would a version of the flag which applied only to
> > > directories be a help here?
> >
> > That's probably the right thing to add.
> 
> I'd vote for an async flag instead.

Why???  Why change the default behaviour to be something much slower?

Cheers,
 Stephen
