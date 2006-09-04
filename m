Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751515AbWIDUeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbWIDUeI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 16:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbWIDUeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 16:34:08 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:65193 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751515AbWIDUeD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 16:34:03 -0400
Date: Mon, 4 Sep 2006 22:33:46 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Shaya Potter <spotter@cs.columbia.edu>
Cc: Josef Sipek <jsipek@cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@ftp.linux.org.uk
Subject: Re: [PATCH 00/22][RFC] Unionfs: Stackable Namespace Unification Filesystem
Message-ID: <20060904203346.GA6646@elf.ucw.cz>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu> <20060903110507.GD4884@ucw.cz> <1157376506.4398.15.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157376506.4398.15.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2006-09-04 09:28:26, Shaya Potter wrote:
> On Sun, 2006-09-03 at 11:05 +0000, Pavel Machek wrote:
> > Hi!
> > 
> > > - Modifying a Unionfs branch directly, while the union is mounted, is
> > >   currently unsupported.  Any such change may cause Unionfs to oops and it
> > >   can even result in data loss!
> > 
> > I'm not sure if that is acceptable. Even root user should be unable to
> > oops the kernel using 'normal' actions.
> 
> As I said in the other case.  imagine ext2/3 on a a san file system
> where 2 systems try to make use of it.  Will they not have issues?

They probably will have issues (altrough I'm not sure, perhaps ext2
has been debugged enough), but they'll fix them (as opposed to
document that oopses are okay).
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
