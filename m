Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285828AbRLYUAc>; Tue, 25 Dec 2001 15:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285783AbRLYUAW>; Tue, 25 Dec 2001 15:00:22 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:58636 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S285812AbRLYT7T>;
	Tue, 25 Dec 2001 14:59:19 -0500
Date: Tue, 25 Dec 2001 11:35:54 +0000
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "\"M. Edward (Ed) Borasky\"" <znmeb@aracnet.com>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Total system lockup with Alt-SysRQ-L
Message-ID: <20011225113554.B37@toy.ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0112240621370.26289-100000@shell1.aracnet.com> <E16IYZu-0004an-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E16IYZu-0004an-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Dec 24, 2001 at 05:07:54PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > option, would be a one-button "sync up all the disks, forbid any more
> > writes, save as much state as possbile (registers, memory) to a swap
> > partition, set a flag for crash dump processing and reboot" capability.
> 
> Very hard to do - you can't trust the I/O systems state so the dump code

Actually... swsusp should be usable for most of this... But swsusp will
not work in bad state and I guess that's showtopper.
 
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

