Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266795AbTBQESa>; Sun, 16 Feb 2003 23:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266796AbTBQESa>; Sun, 16 Feb 2003 23:18:30 -0500
Received: from bjl1.jlokier.co.uk ([81.29.64.88]:21632 "EHLO
	bjl1.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S266795AbTBQES2>; Sun, 16 Feb 2003 23:18:28 -0500
Date: Mon, 17 Feb 2003 04:31:08 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Nicolas Pitre <nico@cam.org>
Cc: David Lang <david.lang@digitalinsight.com>, Larry McVoy <lm@bitmover.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: openbkweb-0.0
Message-ID: <20030217043108.GA16137@bjl1.jlokier.co.uk>
References: <Pine.LNX.4.44.0302152104500.6594-100000@dlang.diginsite.com> <Pine.LNX.4.44.0302160027390.17241-100000@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302160027390.17241-100000@xanadu.home>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Pitre wrote:
> > CVS
> > rsync
> > FTP
> > HTTP
> > 
> > is there anything else people want?
> 
> If you can manage to have a CVS repository that is always updated to the 
> minute with full history info etc. then this should be suficient to satisfy 
> all needs.  Public CVS repositories are common enough so people should know 
> how to use them already.

I expect most people would prefer read-only CVS for keeping up to date.

However, rsync from the repository is generally _much_ faster than CVS
if you are tracking changes, so I (an impatient modem user) prefer rsync.

Also the SCCS repository is more fun for analysis and browsing
programs than a CVS equivalent because some of the metadata would be
lost converting to CVS.

So I vote for rsync read-only access to the actual SCCS-ish repository
files that BK manages.

Ideally you'd ensure the tree offered through rsync was a consistent
snapshot, offer a method of atomically updating the tree seen by rsync
is a consistent snapshot.  (Although this isn't crucial; BK's
changeset files let you detect that at the client I believe).

-- Jamie
