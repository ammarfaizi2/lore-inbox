Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267965AbTAHXGL>; Wed, 8 Jan 2003 18:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267964AbTAHXGL>; Wed, 8 Jan 2003 18:06:11 -0500
Received: from [81.2.122.30] ([81.2.122.30]:26375 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267965AbTAHXGJ>;
	Wed, 8 Jan 2003 18:06:09 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301082314.h08NEe56003842@darkstar.example.net>
Subject: Re: Undelete files on ext3 ??
To: john@grabjohn.com (John Bradford)
Date: Wed, 8 Jan 2003 23:14:40 +0000 (GMT)
Cc: rddunlap@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <200301082303.h08N3bvI003752@darkstar.example.net> from "John Bradford" at Jan 08, 2003 11:03:37 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > | > > What I was thinking of was a virtual device that allocated
> > > | > > a new sector whenever an old one was overwritten - kind of
> > > | > > like a journaled filesystem, but without the filesystem,
> > > | > > (I.E. just the journal) :-).
> > > | >
> > > | > $ DIR FOO.TXT;*
> > > | > FOO.TXT;1   FOO.TXT;2   FOO.TXT;2
> > > | >
> > > | > VMS-style file versioning, anybody? ;)
> > > |
> > > | Brilliant!
> > > 
> > > re-read the archives from 6-8 months ago.
> > 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=101914252421742&w=2
> 
> So basically the idea already already exists:
> 
> http://www.netcraft.com.au/geoffrey/katie/
> 
> Brilliant!  :-)

Although I was originally thinking of doing it at sector level, rather
than at filesystem level.

John.
