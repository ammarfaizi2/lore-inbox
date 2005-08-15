Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932652AbVHODOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932652AbVHODOe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 23:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbVHODOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 23:14:34 -0400
Received: from fsmlabs.com ([168.103.115.128]:33703 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S932652AbVHODOd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 23:14:33 -0400
Date: Sun, 14 Aug 2005 21:20:35 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Robert Love <rlove@rlove.org>
cc: Sonny Rao <sonny@burdell.org>, Neil Brown <neilb@cse.unsw.edu.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>, ziggy@icglink.com,
       scott@icglink.com, jack@icglink.com, Alexander Viro <viro@math.psu.edu>,
       Phil Dier <phil@icglink.com>
Subject: Re: 2.6.13-rc6 Oops with Software RAID, LVM, JFS, NFS
In-Reply-To: <1124075282.13401.116.camel@phantasy>
Message-ID: <Pine.LNX.4.61.0508142119460.6740@montezuma.fsmlabs.com>
References: <20050811105954.31f25407.phil@icglink.com> 
 <17148.1113.664829.360594@cse.unsw.edu.au>  <20050812123505.1515634c.phil@icglink.com>
  <20050812183548.GA2255@kevlar.burdell.org>  <20050814210331.102e005c.phil@icglink.com>
  <Pine.LNX.4.61.0508142031510.6740@montezuma.fsmlabs.com>
 <1124075282.13401.116.camel@phantasy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Aug 2005, Robert Love wrote:

> On Sun, 2005-08-14 at 20:40 -0600, Zwane Mwaikambo wrote:
> 
> > I'm new here, if the inode isn't being watched, what's to stop d_delete 
> > from removing the inode before fsnotify_unlink proceeds to use it?
> 
> Nothing.  But check out
> 
> http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=7a91bf7f5c22c8407a9991cbd9ce5bb87caa6b4a

That git web interface looks rather spiffy.

> Should solve this problem?

Seems to fit the bill perfectly.

Thanks,
	Zwane

