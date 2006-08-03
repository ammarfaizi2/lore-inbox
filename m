Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbWHCEHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbWHCEHl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 00:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWHCEHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 00:07:41 -0400
Received: from xenotime.net ([66.160.160.81]:53396 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932336AbWHCEHk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 00:07:40 -0400
Date: Wed, 2 Aug 2006 21:10:23 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Kyle Davenport <kdavenpo@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: system freeze on cdrom failure
Message-Id: <20060802211023.a4561e37.rdunlap@xenotime.net>
In-Reply-To: <44D17525.2080705@comcast.net>
References: <44D17525.2080705@comcast.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Aug 2006 23:01:41 -0500 Kyle Davenport wrote:

> I posted on this before, and I'm confirming that the problem is still 
> happening at 2.6.17.5.    Problem started with 2.6.15*.   Saw it again 
> in 2.6.16.  If I reboot into 2.6.13, I still see some cdrom and/or scsi 
> errors, but the system does not freeze.  This was from running grip on a 
> music cd.  It also happens just reading most burned cd's or dvd's.  
> 
> Aug  1 23:23:00 quickest kernel: cdrom: dropping to single frame dma
> Aug  1 23:23:02 quickest kernel: BUG: unable to handle kernel NULL 
> pointer dereference at virtual address 0000000c
> 
> Problem drive is Toshiba DVD-ROM SD-M1401 (scsi).  I do not see any 
> errors with the same media in a Yamaha CRW2100S (scsi burner).
> 
> Tyan Thunder K7X-Pro (S2469UNG)/ 2x2400 Athlon MP/ 1GB ram / 1TB disk / 
> gcc 3.2
> 
> This is easily repeatable - please ask for more info!

more info, please.
Like a full backtrace.  And can you test 2.6.18-rc3 also?


---
~Randy
