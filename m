Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262934AbTCNLHD>; Fri, 14 Mar 2003 06:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262966AbTCNLHD>; Fri, 14 Mar 2003 06:07:03 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:37832 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262934AbTCNLHC>;
	Fri, 14 Mar 2003 06:07:02 -0500
Date: Fri, 14 Mar 2003 13:17:46 +0100
From: Jens Axboe <axboe@suse.de>
To: szonyi calin <caszonyi@yahoo.com>
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: Panic with 2.5.64-mm
Message-ID: <20030314121746.GI791@suse.de>
References: <20030314111503.2792.qmail@web40610.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030314111503.2792.qmail@web40610.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 14 2003, szonyi calin wrote:
> Hello
> 
> Kernel 2.5.64 with mm patches dies with "kernel panic,
> killing interrupt handler" when ejecting cdrom 
> (with eject /dev/hdc). 
> 
> System is duron 700 Mhz with via kt133 cipset and 
> radeon ve video card. 
> 
> I didn't had time to copy the panic message but if 
> you can't reproduce it (for me is 100% reproductible)
> i'll send it to you. Programs and glibc are the same 
> as in linux/Documentation/Changes or newer.

Try to boot with elevator=deadline

-- 
Jens Axboe

