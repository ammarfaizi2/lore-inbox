Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266540AbTCDXLh>; Tue, 4 Mar 2003 18:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266622AbTCDXLh>; Tue, 4 Mar 2003 18:11:37 -0500
Received: from packet.digeo.com ([12.110.80.53]:57256 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266540AbTCDXLg>;
	Tue, 4 Mar 2003 18:11:36 -0500
Date: Tue, 4 Mar 2003 15:18:04 -0800
From: Andrew Morton <akpm@digeo.com>
To: Mark Wong <markw@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.63-mm2
Message-Id: <20030304151804.259a6473.akpm@digeo.com>
In-Reply-To: <1046819184.12936.100.camel@ibm-b>
References: <20030302180959.3c9c437a.akpm@digeo.com>
	<1046815078.12931.79.camel@ibm-b>
	<20030304140918.4092f09b.akpm@digeo.com>
	<1046819184.12936.100.camel@ibm-b>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Mar 2003 23:21:58.0975 (UTC) FILETIME=[DA98B4F0:01C2E2A4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Wong <markw@osdl.org> wrote:
>
> Reverting to Linus's 2.5.63 tree produces the same problem for me.  I
> had thought I tried it before, but it turns out I was running 2.5.62. 
> 2.5.62's aic7xxx_old is good for me.

There are no significant differences in that driver between .62 and .63.  So
I am assuming that 2.5.62 works, 2.5.63 doesn't, and that you have not
actually tried 2.5.62's aic7xxx_old in a 2.5.63 tree?

If so, don't bother - it won't make any difference.  Looks like someone broke
something in scsi core which colaterally damaged aic7xxx_old.  I suggest you
feed it into bugme for now.


