Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265475AbTAPAsm>; Wed, 15 Jan 2003 19:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266796AbTAPAsm>; Wed, 15 Jan 2003 19:48:42 -0500
Received: from packet.digeo.com ([12.110.80.53]:52655 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265475AbTAPAsm>;
	Wed, 15 Jan 2003 19:48:42 -0500
Date: Wed, 15 Jan 2003 16:57:24 -0800
From: Andrew Morton <akpm@digeo.com>
To: Ted Phelps <phelps@dstc.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counting bug in svc_tcp_recvfrom causes panic for TCP
 NFS
Message-Id: <20030115165724.16cc714c.akpm@digeo.com>
In-Reply-To: <200301160051.AAA09861@tereshkova.dstc.edu.au>
References: <200301152254.WAA19810@tereshkova.dstc.edu.au>
	<20030115152844.6a66cd0f.akpm@digeo.com>
	<200301160051.AAA09861@tereshkova.dstc.edu.au>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Jan 2003 00:57:23.0759 (UTC) FILETIME=[3B016BF0:01C2BCFA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ted Phelps <phelps@dstc.edu.au> wrote:
>
> Andrew Morton may have said:
> > Ted Phelps <phelps@dstc.edu.au> wrote:
> > >
> > > Perhaps a better solution would be to change page_address() to be
> > > consistently be a function for all memory layouts.
> > 
> > Assuredly.  How about this?
> 
> It no only makes sense and looks good, but it works too!
> 

It looks like Linus has already made the same change, thanks.


