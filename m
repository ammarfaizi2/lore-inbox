Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129525AbRBVERB>; Wed, 21 Feb 2001 23:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129602AbRBVEQl>; Wed, 21 Feb 2001 23:16:41 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:14598 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129525AbRBVEQf>; Wed, 21 Feb 2001 23:16:35 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Date: Thu, 22 Feb 2001 15:16:24 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14996.37528.486223.118752@notabene.cse.unsw.edu.au>
Subject: TESTERS PLEASE - improvements to knfsd for 2.4.2
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Dear all,
 as you may have noticed from earlier postings on these lists, I have
 a bunch of patches that change the way knfsd interacts with
 filesystems.  In particular it makes it possible to export reiserfs
 and other modern filesystesm (providing they have been told how to
 work with knfsd).

 This patch makes some substantial changes to the way knfsd maps a
 filehandle into an actual file, and this has been an easy place for
 obscure bugs to hide in the past.

 So, I am asking for testers.  Anyone who is feeling at all
 adventurous, and uses knfsd for any filesystem type, and is using 2.4
 series kernels: please grab my latest patch, apply it to 2.4.2, and
 try it out.  Then let me know about any problems.

 I am looking forward to seeing lots of downloads and absolutely no
 problem reports.... but is seems unlikely.

 Alan Cox has suggested that these changes may not be appropriate for
 2.4, so we might have to wait for 2.5 to see them on kernel.org, but
 we don't have to wait till then to find the bugs.

 The jumbo-patch is at
   http://www.cse.unsw.edu.au/~neilb/patches/linux/2.4.2/patches-A-H-knfsd

 The individual bits that make it up can be seen by looking a little
 higher in the tree. e.g.

   http://www.cse.unsw.edu.au/~neilb/patches/linux/

 The reiserfs code in this patch is from the reiserfs team.

 Thankyou,

NeilBrown
