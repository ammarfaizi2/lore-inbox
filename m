Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319229AbSIKQ6S>; Wed, 11 Sep 2002 12:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319230AbSIKQ6R>; Wed, 11 Sep 2002 12:58:17 -0400
Received: from flamingo.mail.pas.earthlink.net ([207.217.120.232]:50127 "EHLO
	flamingo.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S319229AbSIKQ6R>; Wed, 11 Sep 2002 12:58:17 -0400
Message-ID: <0b1701c259b5$16d6be40$1125a8c0@wednesday>
From: "jdow" <jdow@earthlink.net>
To: "Davide Libenzi" <davidel@xmailserver.org>,
       "Xuan Baldauf" <xuan--lkml@baldauf.org>
Cc: <linux-kernel@vger.kernel.org>,
       "Reiserfs List" <reiserfs-list@namesys.com>
References: <Pine.LNX.4.44.0209110929390.1576-100000@blue1.dev.mcafeelabs.com>
Subject: Re: Heuristic readahead for filesystems
Date: Wed, 11 Sep 2002 10:03:02 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Davide Libenzi" <davidel@xmailserver.org>
> On Wed, 11 Sep 2002, Xuan Baldauf wrote:
> 
> > Hello,
> >
> > I wonder wether Linux implements a kind of heuristic
> > readahead for filesystems:
> >
> > If an application reads a directory with getdents() and if
> > in the past, it stat()ed a significant part of the directory
> > entries, it is likely that it will stat() every entry of
> > every directory it reads with getdents() in the future. Thus
> > readahead for the stat data could improve the perfomance,
> > especially if the stat data is located closely to each other
> > on disk.
> >
> > If an application did a stat()..open()..read() sequence on a
> > file, it is likely that, after the next stat(), it will open
> > and read the mentioned file. Thus, one could readahead the
> > start of a file on stat() of that file.
> >
> > Combined: If an application walks a directory tree and
> > visits each file, it is likely that it will continue up to
> > the end of that tree.
> 
> M$ Win XP does exactly something like this and keep applications
> ( windows\prefetch ) and boot profiles that it uses to prefetch disk data
> and avoid long page fault latencies. It does kind-of-work but care should
> be taken adopting a similar technique on Linux ( patents ).

Davide, when was the patent on readahead taken out? It has either expired
or I can prove prior art I did myself on the old StarDrive and HardFrame
controllers for the Amiga made by Microbotics, Inc.

{^_^}    Joanne Dow, jdow@earthlink.net


