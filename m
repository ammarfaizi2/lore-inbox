Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269878AbRHDXYv>; Sat, 4 Aug 2001 19:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269877AbRHDXYl>; Sat, 4 Aug 2001 19:24:41 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:43278 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S269880AbRHDXY2>; Sat, 4 Aug 2001 19:24:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Mike Castle <dalgoda@ix.netcom.com>, linux-kernel@vger.kernel.org
Subject: Re: intermediate summary of ext3-2.4-0.9.4 thread
Date: Sat, 4 Aug 2001 05:23:22 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <20010803104920.I437@thune.mrc-home.com>
In-Reply-To: <20010803104920.I437@thune.mrc-home.com>
MIME-Version: 1.0
Message-Id: <0108040523220P.01827@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 August 2001 19:49, Mike Castle wrote:
> On Fri, Aug 03, 2001 at 03:09:06PM +0200, Daniel Phillips wrote:
> > On Friday 03 August 2001 05:13, Alexander Viro wrote:
> > > On Fri, 3 Aug 2001, Daniel Phillips wrote:
> > > > There is only one chain of directories from the fd's dentry up to
> > > > the root, that's the one to sync.
> > >
> > > You forgot ".. at any given moment". IOW, operation you propose is
> > > inherently racy. You want to do that - you do that in userland.
> >
> > Are you saying that there may not be a ".." some of the time?  Or just
> > that it may spontaneously be relinked?  If it does spontaneously change
> > it doesn't matter, you have still made sure there is access by at least
> > one path.
>
> I read the ".." as a typo for "..."  As in Al was suggesting the sentence
> should read "There is only one chain of directories at any given moment
> from the fd's dentry up to the root...."

Heh, after some practice you get good at decoding Alspeak, it's not harder
than MIX.

--
Daniel

