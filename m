Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261916AbREVPuO>; Tue, 22 May 2001 11:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261966AbREVPuE>; Tue, 22 May 2001 11:50:04 -0400
Received: from waste.org ([209.173.204.2]:31344 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S261916AbREVPtx>;
	Tue, 22 May 2001 11:49:53 -0400
Date: Tue, 22 May 2001 10:50:51 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Theodore Tso <tytso@valinux.com>
cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Andrew McNamara <andrewm@connect.com.au>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Ext2, fsync() and MTA's?
In-Reply-To: <20010521180405.D495@think.thunk.org>
Message-ID: <Pine.LNX.4.30.0105221045530.19818-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 May 2001, Theodore Tso wrote:

> On Mon, May 21, 2001 at 06:47:58PM +0100, Stephen C. Tweedie wrote:
>
> > Just set chattr +S on the spool dir.  That's what the flag is for.
> > The biggest problem with that is that it propagates to subdirectories
> > and files --- would a version of the flag which applied only to
> > directories be a help here?
>
> That's probably the right thing to add.

I'd vote for an async flag instead.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

