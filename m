Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130835AbRCJPYE>; Sat, 10 Mar 2001 10:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130620AbRCJPXy>; Sat, 10 Mar 2001 10:23:54 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:1028 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S130481AbRCJPXl>;
	Sat, 10 Mar 2001 10:23:41 -0500
Date: Thu, 8 Mar 2001 11:44:19 +0000
From: Pavel Machek <pavel@suse.cz>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Mike Galbraith <mikeg@wen-online.de>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Ramdisk (and other) problems with 2.4.2
Message-ID: <20010308114418.A31@(none)>
In-Reply-To: <Pine.LNX.4.33.0103071752030.2732-100000@mikeg.weiden.de> <Pine.LNX.3.95.1010307121716.1838A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.3.95.1010307121716.1838A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Wed, Mar 07, 2001 at 12:23:57PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> Script started on Wed Mar  7 12:22:20 2001
> # mke2fs -Fq /dev/ram0 1440
> mke2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
> # mount /dev/ram0 /mnt
> # ls -la /mnt
> total 0
> # umount /mnt
> # exit
> exit

No "." and ".."? something is definitely wrong here!

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

