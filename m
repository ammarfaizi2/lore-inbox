Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268501AbUJMHD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268501AbUJMHD5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 03:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269157AbUJMHD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 03:03:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:27777 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268501AbUJMHD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 03:03:56 -0400
Date: Wed, 13 Oct 2004 00:02:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nathan Scott <nathans@sgi.com>
Cc: piggin@cyberone.com.au, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       linux-xfs@oss.sgi.com
Subject: Re: Page cache write performance issue
Message-Id: <20041013000206.680132ad.akpm@osdl.org>
In-Reply-To: <20041013063955.GA2079@frodo>
References: <20041013054452.GB1618@frodo>
	<20041012231945.2aff9a00.akpm@osdl.org>
	<20041013063955.GA2079@frodo>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Scott <nathans@sgi.com> wrote:
>
> Hi Andrew,
> 
> On Tue, Oct 12, 2004 at 11:19:45PM -0700, Andrew Morton wrote:
> > Nathan Scott <nathans@sgi.com> wrote:
> > >
> > >  So, any ideas what happened to 2.6.9?
> > 
> > Does reverting the below fix it up?
> 
> Reverting that one improves things slightly - I move up from
> ~4MB/sec to ~17MB/sec; thats just under a third of the 2.6.8
> numbers I was seeing though, unfortunately.
> 

Well something else if fishy: how can you possibly achieve only 4MB/sec? 
Using floppy disks or something?

Does the same happen on ext2?

It's exactly a 500MB write on a 1000MB machine, yes?
