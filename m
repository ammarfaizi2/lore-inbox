Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267180AbTBDIHb>; Tue, 4 Feb 2003 03:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267185AbTBDIHb>; Tue, 4 Feb 2003 03:07:31 -0500
Received: from packet.digeo.com ([12.110.80.53]:37583 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267180AbTBDIHa>;
	Tue, 4 Feb 2003 03:07:30 -0500
Date: Tue, 4 Feb 2003 00:17:09 -0800
From: Andrew Morton <akpm@digeo.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.59-mm8
Message-Id: <20030204001709.5e2942e8.akpm@digeo.com>
In-Reply-To: <167540000.1044346173@[10.10.2.4]>
References: <20030203233156.39be7770.akpm@digeo.com>
	<167540000.1044346173@[10.10.2.4]>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Feb 2003 08:16:57.0375 (UTC) FILETIME=[C8C11AF0:01C2CC25]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> > http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.59/2.5.59-mm8/
> 
> Booted to login prompt, then immediately oopsed 
> (16-way NUMA-Q, mm6 worked fine). At a wild guess, I'd suspect 
> irq_balance stuff.
> 

There are a lot of scsi updates in Linus's tree.  Can you please
test just

http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.59/2.5.59-mm8/broken-out/linus.patch
