Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264666AbSKMV4X>; Wed, 13 Nov 2002 16:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264672AbSKMV4X>; Wed, 13 Nov 2002 16:56:23 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:20242 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S264666AbSKMV4W>; Wed, 13 Nov 2002 16:56:22 -0500
Date: Wed, 13 Nov 2002 23:03:14 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@redhat.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: sysfs support for ide disks
Message-ID: <20021113220313.GD27013@atrey.karlin.mff.cuni.cz>
References: <20021113215618.GA8744@elf.ucw.cz> <200211132201.gADM1Fw09895@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211132201.gADM1Fw09895@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I had to select between standby written in ide-disk.c (uses
> > ide_raw_taskfile) and standby written in sc1200.c (uses
> > ide_wait_cmd). I do not know which one is correct, but I tend to trust
> > ide-disk.c version a bit more, and used that.
> 
> They'll both ultimately do the same thing.
> 
> > Apply if it looks good to you,
> 
> Ok will do. My only gripe is about printk levels this time 8)

Well, feel free to kill printks altogether. They are only for me,
anyway.

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
