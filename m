Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133103AbRDRM1Y>; Wed, 18 Apr 2001 08:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133100AbRDRM1P>; Wed, 18 Apr 2001 08:27:15 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:21004 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S133103AbRDRM0P>;
	Wed, 18 Apr 2001 08:26:15 -0400
Date: Wed, 18 Apr 2001 14:25:36 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Giuliano Pochini <pochini@shiny.it>, lna@bigfoot.com,
        linux-kernel@vger.kernel.org
Subject: Re: I can eject a mounted CD
Message-ID: <20010418142536.C490@suse.de>
In-Reply-To: <XFMail.010418092543.pochini@shiny.it> <E14pqzO-0004bp-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E14pqzO-0004bp-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Apr 18, 2001 at 01:23:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18 2001, Alan Cox wrote:
> > > rpm -e magicdev
> > 
> > Magicdev is not installed.
> > Ok, I'm the only one with this problem, I'll manage to find the bug by myself.
> 
> vmware and one or two other apps I've also seen do this. WHen you unlock the
> cdrom door as root you can unlock it even if a file system is mounted

yes, unlocking is definitely possible and then of course a manual eject.
Only by root of course, however an ioctl eject should fail unless the
cdrom really isn't busy (ie mounted or has other opens).

-- 
Jens Axboe

