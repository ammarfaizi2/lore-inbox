Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129675AbQLUCHC>; Wed, 20 Dec 2000 21:07:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129807AbQLUCGw>; Wed, 20 Dec 2000 21:06:52 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:22034 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129675AbQLUCGk>; Wed, 20 Dec 2000 21:06:40 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: nfs@lists.sourceforge.net, nfs-devel@linux.kernel.org
Date: Thu, 21 Dec 2000 12:05:41 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14913.22373.943123.320678@notabene.cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: kNFSd maintenance in 2.2.19pre
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greeting all.

 Now that 2.2.18 is out with all the nfs (client and server) patches
 that we were waiting for for so long, it is time to look at on-going
 maintenance for knfsd.

 There are already a couple of issues that have come up and it is
 quite possible that more will arise as the user-base grows.
 Also, there are quite a few changes that have gone into 2.4 that
 could usefully go into 2.2.

 I have discussed the issue of maintenance with Dave Higgen - the
 maintainer of the knfsd patchset that finally went into 2.2.18, and
 he is happy to leave knfsd for a while and let me run with it.

 So, I have started putting some patches together and they can be
 found at
    http://www.cse.unsw.edu.au/~neilb/patches/knfsd-2.2/

 They are mostly back ports of bits from 2.4 with a couple of real bug
 fixes, one thanks to Chip Salzenberg and one which allows Solaris
 clients to access /dev/null over NFSv3 properly.

 I hope to feed these patches to Alan for inclusion in 2.2.19-preX
 early in the new year after I (and you?) have done a bit of testing.

 Note: the patches aren't all quite as independant as they should be
 just at the moment (e.g. I made a patch, started on another and then
 found a bug in the first, so the fix for the first ended up in the
 second).  This will get sorted out next time I generate a patch set.

NeilBrown
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
