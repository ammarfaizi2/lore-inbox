Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264286AbUH1N5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbUH1N5J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 09:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266786AbUH1N5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 09:57:09 -0400
Received: from verein.lst.de ([213.95.11.210]:52892 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S264286AbUH1N5D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 09:57:03 -0400
Date: Sat, 28 Aug 2004 15:56:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: flx@msu.ru, Christoph Hellwig <hch@lst.de>,
       Christophe Saout <christophe@saout.de>, Andrew Morton <akpm@osdl.org>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com, torvalds@osdl.org,
       reiserfs-list@namesys.com
Subject: Re: reiser4 plugins (was: silent semantic changes with reiser4)
Message-ID: <20040828135655.GA13380@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, flx@msu.ru,
	Christophe Saout <christophe@saout.de>,
	Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	flx@namesys.com, torvalds@osdl.org, reiserfs-list@namesys.com
References: <20040826014542.4bfe7cc3.akpm@osdl.org> <1093522729.9004.40.camel@leto.cs.pocnet.net> <20040826124929.GA542@lst.de> <1093525234.9004.55.camel@leto.cs.pocnet.net> <20040826130718.GB820@lst.de> <1093526273.11694.8.camel@leto.cs.pocnet.net> <20040826132439.GA1188@lst.de> <20040828105929.GB6746@alias> <20040828111233.GA11339@lst.de> <20040828120502.GE6746@alias>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040828120502.GE6746@alias>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 04:05:02PM +0400, Alexander Lyamin wrote:
> > But one could even say VFS is integral part of a linux filesystem as
> > it does most of the work a filesystem driver does in other operating
> > systems.
> 
> theres no "linux filesystem". there are "linux filesystems".
> thanks god.

a linux filesystem, not the linux filesystem, please read again.

> But I it would be really grate if you'll elaborate your sentence with
> example of VFS functionality (lack of it) on said "other operating systems"
> and if you'll define "most of work".

most trivial example is namespace locking, in *BSD, Windows, SVR4 and
derivates it's done in the lowlevel filesystem.  In plan9, Linux and
soon DragonlyBSD it's done in the VFS. 

> > > P.S. I imagine, how much flamed it would be if reiser4 made any intensive
> > > changes in linux VFS code...
> > 
> > It really depends on how you sent them.  If you had a big patch without
> > explanations - sure.
> It would work with small tweaks, but you just can take a look at reiser4
> code and you'll understand that it just could not be chopped in
> "set of small patches" altough it could be documented better ofcourse,
> but its really well commented already.
> 
> some times, some approaches to  some problems  just would not work.

You still haven't even bother explaining what you want to do.  It's hard
to argue against vague uncertainity.

