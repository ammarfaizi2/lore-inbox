Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbTDXIsr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 04:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbTDXIsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 04:48:46 -0400
Received: from [12.47.58.68] ([12.47.58.68]:37905 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S261899AbTDXIsp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 04:48:45 -0400
Date: Thu, 24 Apr 2003 02:01:45 -0700
From: Andrew Morton <akpm@digeo.com>
To: Pavel Machek <pavel@suse.cz>
Cc: mbligh@aracnet.com, ncunningham@clear.net.nz, gigerstyle@gmx.ch,
       geert@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: Fix SWSUSP & !SWAP
Message-Id: <20030424020145.5066acbf.akpm@digeo.com>
In-Reply-To: <20030424002544.GC2925@elf.ucw.cz>
References: <1051136725.4439.5.camel@laptop-linux>
	<1584040000.1051140524@flay>
	<20030423235820.GB32577@atrey.karlin.mff.cuni.cz>
	<20030423170759.2b4e6294.akpm@digeo.com>
	<20030424002544.GC2925@elf.ucw.cz>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Apr 2003 09:00:47.0289 (UTC) FILETIME=[FEF06290:01C30A3F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> wrote:
>
> Hi!
> 
> > > If you really want to "solve" it reliably, you can always
> > > 
> > > swapon /dev/hdfoo666
> > > 
> > 
> > Seems that using a swapfile instead of a swapdev would fix that neatly.
> > 
> > But iirc, suspend doesn't work with swapfiles.  Is that correct?  If so,
> > what has to be done to get it working?
> 
> Swapfile does not work, because even readonly mount wants to replay
> logs, and that'd be disk corruption.
> 

I don't get it.   Can you explain some more?
