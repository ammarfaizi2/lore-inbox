Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265823AbSKFRCM>; Wed, 6 Nov 2002 12:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265837AbSKFRCM>; Wed, 6 Nov 2002 12:02:12 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:9915 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265823AbSKFRCL>;
	Wed, 6 Nov 2002 12:02:11 -0500
Date: Wed, 6 Nov 2002 18:08:44 +0100
From: Jens Axboe <axboe@suse.de>
To: Ewan Mac Mahon <ecm103@york.ac.uk>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Christopher Li <chrisl@vmware.com>,
       "'Linux Kernel '" <linux-kernel@vger.kernel.org>,
       "'ext2-devel@lists.sourceforge.net '" 
	<ext2-devel@lists.sourceforge.net>
Subject: Re: [Ext2-devel] Re: 2.5.46 ext3 errors
Message-ID: <20021106170844.GA897@suse.de>
References: <3C77B405ABE6D611A93A00065B3FFBBA36A493@PA-EXCH2> <20021106101806.B2663@redhat.com> <20021106130521.GB839@suse.de> <20021106161234.GB17138@york.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021106161234.GB17138@york.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06 2002, Ewan Mac Mahon wrote:
> On Wed, Nov 06, 2002 at 02:05:21PM +0100, Jens Axboe wrote:
> > On Wed, Nov 06 2002, Stephen C. Tweedie wrote:
> > > 
> > > error is just ext3's normal reaction to a fatal error detected in the
> > > filesystem, so that in itself isn't a worry.  The cause of the problem
> > > it spotted is the worry; is this reproducible?
> > 
> > I can try. The kernel run had my rbtree deadline patches, however
> > they've been well tested and are likely not the cause of the problem. It
> > cannot be 100% ruled out though, I'm testing for this very thing right
> > now. I will let you know what happens.
> 
> I think I can rule that out, I've got much the same[1] from a vanilla 
> 2.5.46, and the filesystem's recent history has been plain 2.5.XXs as 
> well.

Interesting, so it smells like a generic problem. I cannot reproduce it
on my test box (been running kernel compiles and dbenches all afternoon)
with the same kernel. I've got 2.5.46-BK on the desktop again now, we'll
see what happens....

For the record, test box is P3-800MHz SMP, 512MiB RAM. Desktop is a
MP1800+ SMP, 1GiB of RAM.

-- 
Jens Axboe

