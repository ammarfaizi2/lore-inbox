Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290860AbSBLJMV>; Tue, 12 Feb 2002 04:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290839AbSBLJLd>; Tue, 12 Feb 2002 04:11:33 -0500
Received: from mail.cogenit.fr ([195.68.53.173]:10414 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S290860AbSBLJKd>;
	Tue, 12 Feb 2002 04:10:33 -0500
Date: Tue, 12 Feb 2002 10:10:27 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: Problem with mke2fs on huge RAID-partition
Message-ID: <20020212101027.A14377@fafner.intra.cogenit.fr>
In-Reply-To: <20020211195710.A12859@fafner.intra.cogenit.fr> <Pine.LNX.3.96.1020211155518.1149A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.96.1020211155518.1149A-100000@gatekeeper.tmr.com>; from davidsen@tmr.com on Mon, Feb 11, 2002 at 03:57:22PM -0500
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> :
[...]
> What's your stripe size? I have that "this works for me" feeling, although

raiddev                 /dev/md20
raid-level              1
nr-raid-disks           2
chunk-size              32k
persistent-superblock   1
nr-spare-disks          0
        device          /dev/hde3
        raid-disk       0
        device          /dev/hdg3
        raid-disk       1

/dev/md10 is built on hda3, hdc3 the same way.

> I'd like to know why the drives didn't autotune just the same way, and
> that might tell someone what's up.

I'd like too. Datasheet anyone ?

-- 
Ueimor
