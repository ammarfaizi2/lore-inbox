Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293041AbSCJNto>; Sun, 10 Mar 2002 08:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293042AbSCJNtf>; Sun, 10 Mar 2002 08:49:35 -0500
Received: from mail.cogenit.fr ([195.68.53.173]:40885 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S293041AbSCJNtU>;
	Sun, 10 Mar 2002 08:49:20 -0500
Date: Sun, 10 Mar 2002 14:49:13 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RAID magics gone...
Message-ID: <20020310144913.A25422@fafner.intra.cogenit.fr>
In-Reply-To: <200203100914.KAA14394@cave.bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200203100914.KAA14394@cave.bitwizard.nl>; from R.E.Wolff@BitWizard.nl on Sun, Mar 10, 2002 at 10:14:30AM +0100
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogier Wolff <R.E.Wolff@BitWizard.nl> :
[...]
> I have a machine with 4 160G disks in a raid-0 configuration. Now
> after upgrading the hardware, all of a sudden raidstart can't find the
> raid-superblocks anymore. Invalid magic. 
> 
> I'm suspecting that it might be that the superblock was overwritten
> with data or something like that. Does anybody know of a bug like
> this?

Cut some configuration options behind "Advanced partition selection" ?

I experienced the same symptoms 2 days ago (IDE+1 raid autodetect partition
+raid1+2.4.18-pre7-"akpm"). No superblock corruption here but a side effect
of a rescue installation in swap space.

-- 
Ueimor
