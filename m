Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267884AbTBVB7W>; Fri, 21 Feb 2003 20:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267769AbTBVB7W>; Fri, 21 Feb 2003 20:59:22 -0500
Received: from packet.digeo.com ([12.110.80.53]:7042 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267884AbTBVB7U>;
	Fri, 21 Feb 2003 20:59:20 -0500
Date: Fri, 21 Feb 2003 18:09:29 -0800
From: Andrew Morton <akpm@digeo.com>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.62-mm2
Message-Id: <20030221180929.37ba5f57.akpm@digeo.com>
In-Reply-To: <200302212048.09802.tomlins@cam.org>
References: <20030220234733.3d4c5e6d.akpm@digeo.com>
	<200302212048.09802.tomlins@cam.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Feb 2003 02:09:22.0532 (UTC) FILETIME=[6A7AA240:01C2DA17]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson <tomlins@cam.org> wrote:
>
> On February 21, 2003 02:47 am, Andrew Morton wrote:
> > So this tree has three elevators (apart from the no-op elevator).  You can
> > select between them via the kernel boot commandline:
> >
> >         elevator=as
> >         elevator=cfq
> >         elevator=deadline
> 
> Has anyone been having problems booting with 'as'?  It hangs here at the point
> root gets mounted readonly.  cfq works ok.

Might be another jiffy handling problem.  Would be appreciated if you could
retest with a patch -R of

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.62/2.5.62-mm2/broken-out/initial-jiffies.patch

