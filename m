Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135719AbRDYMUb>; Wed, 25 Apr 2001 08:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135842AbRDYMUV>; Wed, 25 Apr 2001 08:20:21 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:2820 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S135719AbRDYMUF>;
	Wed, 25 Apr 2001 08:20:05 -0400
Message-ID: <20010422164210.A198@bug.ucw.cz>
Date: Sun, 22 Apr 2001 16:42:10 +0200
From: Pavel Machek <pavel@suse.cz>
To: Wayne.Brown@altec.com, linux-kernel@vger.kernel.org
Subject: Re: Current status of NTFS support
In-Reply-To: <86256A34.0079A841.00@smtpnotes.altec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <86256A34.0079A841.00@smtpnotes.altec.com>; from Wayne.Brown@altec.com on Fri, Apr 20, 2001 at 05:08:53PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Where does write support for NTFS stand at the moment?  I noticed that it's
> still marked "Dangerous" in the kernel configuration.  This is important to me
> because it looks like I'll have to start using it next week.  My office laptop
> is going to be "upgraded" from Windows 98 to 2000.  Of course, I hardly ever
> boot into Windows any more since installing a Linux partition last year.  But
> our corporate email standard forces me to use Lotus Notes, which I run under
> Wine.   The Notes executables and databases are installed on my Windows
> partition.  The upgrade, though, will involve wiping the hard drive, allocating
> the whole drive to a single NTFS partition, and reinstalling Notes after
> installing Windows 2000 .  That means bye-bye FAT32 partition and hello NTFS.  I
> can't mount it read-only because I'll still have to update my Notes databases
> from Linux.  So how risky is this?

You need to update notes databases. Fine. Why not 
cp -a /ntfs/lotus.databases /usr and only ever update them on ext2?

Granted, you will not be able to use lotus notes under w2000. Does it
matter?
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
