Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312962AbSDBWRA>; Tue, 2 Apr 2002 17:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312972AbSDBWQu>; Tue, 2 Apr 2002 17:16:50 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:4752 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S312962AbSDBWQm>;
	Tue, 2 Apr 2002 17:16:42 -0500
Date: Tue, 2 Apr 2002 17:16:42 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
To: <linux-kernel@vger.kernel.org>
Subject: Question about 'Hidden' Directories in ext2
Message-ID: <Pine.LNX.4.30.0204021704360.6590-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, so some hackers broke into one of our boxes and set up an ftp site.
They monopolized over 70gb of hard drive space with warez and porn.  We
aren't really that upset about it, since we thought it was kind of funny.
(Of course we don't like the idea that they are using out bandwidth and
disk space, but we can easily remedy that).

Anyway, the weird thing is they created 2 directories, both of which were
strangely hidden.  You can cd into them but you can't ls them.  I

/usr/lib/ypx and /usr/man/ypx were the two directories that contained both
the ftp software and the ftp root.  When you are in /usr/man and you do an
ls, you don't see the ypx directory (same when you are in /usr/lib).  The
ls binary we got is right off the redhat cd so it shouldn't still be
compromised by whatever rootkit was installed.

My question is this: can the data structures in ext2fs be somehow hacked
so a directory can't appear in a listing but can be otherwise located for
a stat or a chdir?  I should think no.. maybe we still haven't gotten rid
of the rootkit...

-Calin


