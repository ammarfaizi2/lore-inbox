Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131057AbRBVDGG>; Wed, 21 Feb 2001 22:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131023AbRBVDF5>; Wed, 21 Feb 2001 22:05:57 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:49924 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129839AbRBVDFu>; Wed, 21 Feb 2001 22:05:50 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Matt Stegman <mas9483@cis.ksu.edu>
Date: Thu, 22 Feb 2001 14:05:15 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14996.33259.965914.505080@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: partitions for RAID volumes?
In-Reply-To: message from Matt Stegman on Wednesday February 21
In-Reply-To: <14996.16520.832011.18@notabene.cse.unsw.edu.au>
	<Pine.GSO.4.21.0102212039100.28766-100000@polaris.cis.ksu.edu>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday February 21, mas9483@cis.ksu.edu wrote:
> On Thu, 22 Feb 2001, Neil Brown wrote:


Paragraph 1
> > Using this, I can RAID1 hda and hdc together as md0 == mda and then
> > partition it up as mda1 (root) mda2 (swap) mda3 (other).  And if I
> > have too, I can boot off either drive individually with any raid
> > happening.
> 

Paragraph 2
> Is there any particular reason to prefer this over LVM?  With 2.4, LVM can
> be a layer atop of software RAID, allowing for multiple volumes, online
> volume resizing, and other cool things.
> 
> -Matt Stegman
> <mas9483@cis.ksu.edu>
> 


Paragraph 1 is my answer to paragraph 2.

Also, I don't particularly want to use LVM.  Partitions work fine for
me.  I don't need to learn new tools.

It's about choice.

NeilBrown
