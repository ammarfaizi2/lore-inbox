Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbVIWSON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbVIWSON (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 14:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbVIWSON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 14:14:13 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:31834 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751125AbVIWSOM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 14:14:12 -0400
Date: Fri, 23 Sep 2005 20:14:36 +0200
From: Jens Axboe <axboe@suse.de>
To: Fawad Lateef <fawadlateef@gmail.com>
Cc: Block Device <blockdevice@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Trapping Block I/O
Message-ID: <20050923181435.GI22655@suse.de>
References: <64c7635405092305433356bd17@mail.gmail.com> <1e62d137050923103843058e92@mail.gmail.com> <20050923180407.GG22655@suse.de> <1e62d137050923111046d0b762@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e62d137050923111046d0b762@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23 2005, Fawad Lateef wrote:
> On 9/23/05, Jens Axboe <axboe@suse.de> wrote:
> > On Fri, Sep 23 2005, Fawad Lateef wrote:
> > > you created wrapper .... So by doing this you can easily monitor
> > > requests (similar to this approach is used in LVM/RAID) ......
> >
> > Or just use btrace, pull it from:
> >
> > git://brick.kernel.dk/data/git/blktrace.git
> >
> 
> Thnx for telling about btrace .... I havn't tried/looked at it before !!!!

Well it's pretty new, so no wonder. But it should do everything you want
and lots more. There's a list for it here:

linux-btrace@vger.kernel.org

I'm a little pressed for time these days, but I'll do a proper announce
/ demo of all the features starting next week since it's basically
feature complete now.

If you don't use git, there are also snapshots available on kernel.org,
more precisely here:

kernel.org/pub/linux/kernel/people/axboe/blktrace/

but kernel.org is pretty slow these days, so pulling from the git repo
above is greatly recommended.

-- 
Jens Axboe

