Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267335AbTALJNR>; Sun, 12 Jan 2003 04:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267336AbTALJNR>; Sun, 12 Jan 2003 04:13:17 -0500
Received: from tomts16.bellnexxia.net ([209.226.175.4]:42180 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S267335AbTALJNQ>; Sun, 12 Jan 2003 04:13:16 -0500
Date: Sun, 12 Jan 2003 04:22:10 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Sam Ravnborg <sam@ravnborg.org>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: more thoughts on kernel config organization
In-Reply-To: <20030112080406.GA1006@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0301120421010.24231-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jan 2003, Sam Ravnborg wrote:

> On Sat, Jan 11, 2003 at 11:17:46PM -0500, Robert P. J. Day wrote:
> >   how about something like
> > 
> >   ext2
> >   ext3
> >   reiser
> >   XFS
> >   JFS
> >   quotas
> >   MS/DOS related filesystems
> >     MD-DOS
> >     VFAT
> >     NTFS
> >   other OS-related filessytems
> >     Apple
> >     ADFS
> >     BeOS
> >     BFS
> >     QNX
> >     System V/XENIX/...
> >   Pseudo(?) filessytems
> >     /proc
> >     /dev/pts
> >     /dev
> 
> I like the structure proposed above. I for myself has often wondered why
> ext2 was not named ext2, and hidden between lots of less used stuff.
> If you sort in alphabetic order, then be consistent.
> 
> If you are going to reorganise fs/Kconfig I would suggest moving
> ext3, reiserfs etc. specific stuff down in their respective directories,
> and then source as appropriate.
> There is no reason to keep that in a centralised placed, when it can
> be distributed.
> For simple (Kconfig wise) stuff like CODA or Intermezzo keep them
> in fs/KConfig.

a couple hours ago, i posted an alternate fs/Kconfig file, but i haven't 
seen it appear on the mailing list.  is there a size limit for postings?
is there another way to make it available for anyone who wants to check
it out?

rday

