Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129127AbRBGCtD>; Tue, 6 Feb 2001 21:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129237AbRBGCsw>; Tue, 6 Feb 2001 21:48:52 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:29702 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129127AbRBGCsq>; Tue, 6 Feb 2001 21:48:46 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Paul Jakma <paul@clubi.ie>
Date: Wed, 7 Feb 2001 13:48:09 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14976.46953.953266.499309@notabene.cse.unsw.edu.au>
Cc: Samuel Flory <sflory@valinux.com>, Josh Durham <jmd@aoe.vt.edu>,
        <reiserfs-list@namesys.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [reiserfs-list] NFS and reiserfs
In-Reply-To: message from Paul Jakma on Tuesday February 6
In-Reply-To: <3A7F0492.AD31A2FC@valinux.com>
	<Pine.LNX.4.31.0102060050500.10669-100000@fogarty.jakma.org>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday February 6, paul@clubi.ie wrote:
> On Mon, 5 Feb 2001, Samuel Flory wrote:
> 
> > someone (you?) talking about v3 issues with SGI boxes under 2.4 on the
> > nfs list.  I didn't much pay much attention as it wasn't an issue I
> > could help with.
> 
> that might have been me...
> 
> the issues were related to how IRIX nfs client expects server to
> behave wrt to device files and other special files. First problemo
> was fixed, second one (FIFOs) is apparently undefined for NFS.

Just FYI, these should be completely fixed by 
  http://www.cse.unsw.edu.au/~neilb/patches/knfsd-2.2/2.2.19-pre8/patch-F-nfsirix
already submitted to Alan and
  http://www.cse.unsw.edu.au/~neilb/patches/linux/2.4.2-pre1/patch-D-nfsirix
not yet submitted to Linus.

NeilBrown
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
