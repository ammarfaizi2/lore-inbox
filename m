Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264515AbTKNFbG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 00:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264509AbTKNFbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 00:31:06 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:12463 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S264502AbTKNFbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 00:31:01 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Daniel Gryniewicz <dang@fprintf.net>
Date: Fri, 14 Nov 2003 16:30:42 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16308.26754.867801.131463@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: [RFCI] How best to partition MD/raid devices in 2.6
In-Reply-To: message from Daniel Gryniewicz on Friday November 14
References: <16308.18387.142415.469027@notabene.cse.unsw.edu.au>
	<1068787304.4157.8.camel@localhost>
X-Mailer: VM 7.17 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday November 14, dang@fprintf.net wrote:
> On Thu, 2003-11-13 at 22:11, Neil Brown wrote:
> > RFCI == Request For Clever Ideas.
> > 
> > Hi all..
> > 
> >  I want be able to partition "md" raid arrays.
> >  e.g. I want to be able to use RAID1 to mirror sda and sdb as whole
> >  drives, and then partitions that into root, swap, other (or whatever
> >  suits the particular situation).
> 
> <snip>
> 
> Can't LVM do this?  I have a raid array (mirror) that is LVM'd into
> multiple partitions.  It currently runs 2.4, but it should work fine
> with 2.6, right?  All the rest of my boxes have 2.6 and LVM, but no raid
> (no duplicate hard drives).

Fair question.
I want it to work with "standard" partition tables such as MSDOS
partitions etc.
I would like to be able to take a single drive that is being used and
has partitions on it, and to add an identical drive beside it, mirror
them, and get a mirrored pair that looked much like the original
drive.
There are issues with the raid superblock but assuming they can be
solved, I want partitioning to work easily.

Can LVM work happily with 'legacy' partitioning information?

NeilBrown
