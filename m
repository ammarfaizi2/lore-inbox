Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280935AbRKGTjJ>; Wed, 7 Nov 2001 14:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280936AbRKGTi5>; Wed, 7 Nov 2001 14:38:57 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:1332 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S280935AbRKGTiu>; Wed, 7 Nov 2001 14:38:50 -0500
Date: Wed, 7 Nov 2001 21:38:37 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: James A Sutherland <jas88@cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 vs resiserfs vs xfs
Message-ID: <20011107213837.F26218@niksula.cs.hut.fi>
In-Reply-To: <E161UYR-0004S5-00@the-village.bc.nu> <E161Vbf-0000m9-00@lilac.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E161Vbf-0000m9-00@lilac.csi.cam.ac.uk>; from jas88@cam.ac.uk on Wed, Nov 07, 2001 at 04:31:24PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2001 at 04:31:24PM +0000, you [James A Sutherland] claimed:
> 
> Hm.. after a decidedly unclean shutdown, I decided to force an fsck here
> and my ext3 partition DID have two inode errors on fsck... (Having said
> that, the last entry in syslog was from the SCSI driver, and ext3's
> journalling probably doesn't help much when the disk it's on goes AWOL...)

A stupid question: does ext3 replay the journal before fsck? If not, the
inode errors would be expected...


-- v --

v@iki.fi
