Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130728AbRBVCqt>; Wed, 21 Feb 2001 21:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129839AbRBVCqj>; Wed, 21 Feb 2001 21:46:39 -0500
Received: from polaris.cis.ksu.edu ([129.130.10.93]:58833 "EHLO
	polaris.cis.ksu.edu") by vger.kernel.org with ESMTP
	id <S129170AbRBVCqb>; Wed, 21 Feb 2001 21:46:31 -0500
Date: Wed, 21 Feb 2001 20:47:36 -0600 (CST)
From: Matt Stegman <mas9483@cis.ksu.edu>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: partitions for RAID volumes?
In-Reply-To: <14996.16520.832011.18@notabene.cse.unsw.edu.au>
Message-ID: <Pine.GSO.4.21.0102212039100.28766-100000@polaris.cis.ksu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Feb 2001, Neil Brown wrote:

> On Wednesday February 21, Wilfried.Weissmann@gmx.at wrote:
> > Hi,
> > 
> > Is there any chance that RAID volumes would support partitions like the
> > hard-disk driver in the future? 
> 
> Yep.
> See: http://www.cse.unsw.edu.au/~neilb/patches/linux/2.4.2-pre4/
> 
> You would need patches H,I,N,O,P,Q,R,  and you should consider this a
> very early release, but it works for me.
> ...
> Using this, I can RAID1 hda and hdc together as md0 == mda and then
> partition it up as mda1 (root) mda2 (swap) mda3 (other).  And if I
> have too, I can boot off either drive individually with any raid
> happening.

Is there any particular reason to prefer this over LVM?  With 2.4, LVM can
be a layer atop of software RAID, allowing for multiple volumes, online
volume resizing, and other cool things.

-Matt Stegman
<mas9483@cis.ksu.edu>


