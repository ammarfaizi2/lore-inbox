Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267625AbUH1TYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267625AbUH1TYJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 15:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267632AbUH1TYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 15:24:09 -0400
Received: from alias.nmd.msu.ru ([193.232.127.67]:60687 "EHLO alias.nmd.msu.ru")
	by vger.kernel.org with ESMTP id S267615AbUH1TXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 15:23:53 -0400
Date: Sat, 28 Aug 2004 23:23:50 +0400
From: Alexander Lyamin <flx@msu.ru>
To: Christoph Hellwig <hch@lst.de>, flx@msu.ru,
       Christophe Saout <christophe@saout.de>, Andrew Morton <akpm@osdl.org>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com, torvalds@osdl.org,
       reiserfs-list@namesys.com
Subject: Re:  reiser4 plugins (was: silent semantic changes with reiser4)
Message-ID: <20040828192350.GI6746@alias>
Reply-To: flx@msu.ru
Mail-Followup-To: flx@msu.ru, Christoph Hellwig <hch@lst.de>,
	Christophe Saout <christophe@saout.de>,
	Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	flx@namesys.com, torvalds@osdl.org, reiserfs-list@namesys.com
References: <1093522729.9004.40.camel@leto.cs.pocnet.net> <20040826124929.GA542@lst.de> <1093525234.9004.55.camel@leto.cs.pocnet.net> <20040826130718.GB820@lst.de> <1093526273.11694.8.camel@leto.cs.pocnet.net> <20040826132439.GA1188@lst.de> <20040828105929.GB6746@alias> <20040828111233.GA11339@lst.de> <20040828120502.GE6746@alias> <20040828135655.GA13380@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040828135655.GA13380@lst.de>
X-Operating-System: Linux 2.6.5-7.104-smp
X-Fnord: +++ath
X-WebTV-Stationery: Standard; BGColor=black; TextColor=black
X-Message-Flag: Message text blocked: ADULT LANGUAGE/SITUATIONS
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sat, Aug 28, 2004 at 03:56:55PM +0200, Christoph Hellwig wrote:
> On Sat, Aug 28, 2004 at 04:05:02PM +0400, Alexander Lyamin wrote:
> > > But one could even say VFS is integral part of a linux filesystem as
> > > it does most of the work a filesystem driver does in other operating
> > > systems.
> > 
> > theres no "linux filesystem". there are "linux filesystems".
> > thanks god.
> 
> a linux filesystem, not the linux filesystem, please read again.
> 
> > But I it would be really grate if you'll elaborate your sentence with
> > example of VFS functionality (lack of it) on said "other operating systems"
> > and if you'll define "most of work".
> 
> most trivial example is namespace locking, in *BSD, Windows, SVR4 and
> derivates it's done in the lowlevel filesystem.  In plan9, Linux and
> soon DragonlyBSD it's done in the VFS. 

ok. good examples.

> 
> > > > P.S. I imagine, how much flamed it would be if reiser4 made any intensive
> > > > changes in linux VFS code...
> > > 
> > > It really depends on how you sent them.  If you had a big patch without
> > > explanations - sure.
> > It would work with small tweaks, but you just can take a look at reiser4
> > code and you'll understand that it just could not be chopped in
> > "set of small patches" altough it could be documented better ofcourse,
> > but its really well commented already.
> > 
> > some times, some approaches to  some problems  just would not work.
> 
> You still haven't even bother explaining what you want to do.  It's hard
> to argue against vague uncertainity.

 o files as directories -  no oppinion on that.
                            
 o metafiles -   AFAIK it was product of Nikita Danilov just playing and fooling.

Probably solution that will satisfy you is to have "legacy (dumb?) mode" which
is leaving all this fancy stuff out of sight.

-- 
"the liberation loophole will make it clear.."
lex lyamin
