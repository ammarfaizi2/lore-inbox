Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280857AbRKGQbu>; Wed, 7 Nov 2001 11:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280852AbRKGQbl>; Wed, 7 Nov 2001 11:31:41 -0500
Received: from lilac.csi.cam.ac.uk ([131.111.8.44]:16099 "EHLO
	lilac.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S280857AbRKGQb1>; Wed, 7 Nov 2001 11:31:27 -0500
Content-Type: text/plain; charset=US-ASCII
From: James A Sutherland <jas88@cam.ac.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        roy@karlsbakk.net (Roy Sigurd Karlsbakk)
Subject: Re: ext3 vs resiserfs vs xfs
Date: Wed, 7 Nov 2001 16:31:24 +0000
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E161UYR-0004S5-00@the-village.bc.nu>
In-Reply-To: <E161UYR-0004S5-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E161Vbf-0000m9-00@lilac.csi.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 November 2001 3:23 pm, Alan Cox wrote:
> > I just set up a RedHat 7.2 box with ext3, and after a few tests/chrashes,
> > I see no difference at all. After a chrash, it really wants to run fsck
> > anyway. I've tried ReiserFS before, with no fsck after chrashes - is this
>
> Umm RH 7.2 after an unexpected shutdown will give you a 5 second count down
> when you can choose to force an fsck - ext3 doesnt need an fsck but
> sometimes folks might want to force it thats all

Hm.. after a decidedly unclean shutdown, I decided to force an fsck here and 
my ext3 partition DID have two inode errors on fsck... (Having said that, the 
last entry in syslog was from the SCSI driver, and ext3's journalling 
probably doesn't help much when the disk it's on goes AWOL...)


James.
