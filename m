Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750842AbWHZUda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbWHZUda (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 16:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbWHZUda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 16:33:30 -0400
Received: from p02c11o143.mxlogic.net ([208.65.145.66]:61348 "EHLO
	p02c11o143.mxlogic.net") by vger.kernel.org with ESMTP
	id S1750842AbWHZUda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 16:33:30 -0400
Date: Sat, 26 Aug 2006 23:33:19 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: T60 not coming out of suspend to RAM
Message-ID: <20060826203319.GC21703@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20060825115849.GG221@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060825115849.GG221@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 26 Aug 2006 20:39:40.0421 (UTC) FILETIME=[C0FF8B50:01C6C94F]
X-Spam: [F=0.0100000000; S=0.010(2006081701)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Thomas Glanzmann <sithglan@stud.uni-erlangen.de>:
> Subject: Re: T60 not coming out of suspend to RAM
> 
> Hello,
> oh and before I forget about this:
> 
>         Turn SATA in Bios to compatibility mode And don't forget about
>         the following kernel patch: Otherwise you don't have a disk
>         after the resume. But the buffer cache is still there. ;-)
> 
> http://vizzzion.org/stuff/thinkpad-t60/libata-acpi.diff
> 
> and yes, it is currently no fun to run a t60 under linux but it can only
> get better.
> 
>         Thomas
> 

I do indeed not have a disk after resume - get a bunch of errors
out of libata.
Is this patch still needed under 2.6.18 git?
If yes, is there an updated version?

-- 
MST
