Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131529AbRCNUXh>; Wed, 14 Mar 2001 15:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131531AbRCNUX2>; Wed, 14 Mar 2001 15:23:28 -0500
Received: from stine.vestdata.no ([195.204.68.10]:22788 "EHLO
	stine.vestdata.no") by vger.kernel.org with ESMTP
	id <S131516AbRCNUXO>; Wed, 14 Mar 2001 15:23:14 -0500
Date: Wed, 14 Mar 2001 21:21:05 +0100
From: Ragnar Kjørstad <kernel@ragnark.vestdata.no>
To: Alexander Viro <viro@math.psu.edu>
Cc: Andreas Dilger <adilger@turbolinux.com>,
        Linux kernel development list <linux-kernel@vger.kernel.org>,
        Linux FS development list <linux-fsdevel@vger.kernel.org>
Subject: Re: (struct dentry *)->vfsmnt;
Message-ID: <20010314212105.C26991@vestdata.no>
In-Reply-To: <200103141914.f2EJEVN10163@webber.adilger.int> <Pine.GSO.4.21.0103141428490.4468-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 0.95.5i
In-Reply-To: <Pine.GSO.4.21.0103141428490.4468-100000@weyl.math.psu.edu>; from Alexander Viro on Wed, Mar 14, 2001 at 02:32:21PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2001 at 02:32:21PM -0500, Alexander Viro wrote:
> Sorry - .last.mounted in the root of filesystem, indeed.
> 
> > The writing side can't be done in userland without basically making
> > mount(8) know about the superblock layout of each and every filesystem:
> 
> That's a wonderful reason to put it _not_ into superblock... OK, what's
> wrong with the variant above?


The information will not be available without mounting the filesystem
first.

However - the LVM way sounded much better, so this may not matter.


-- 
Ragnar Kjørstad
Big Storage
