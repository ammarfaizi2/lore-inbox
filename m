Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264032AbUDBMi2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 07:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264034AbUDBMi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 07:38:28 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:19911 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264032AbUDBMi1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 07:38:27 -0500
Date: Fri, 2 Apr 2004 14:38:24 +0200
From: Jens Axboe <axboe@suse.de>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.5-rc3-mm2
Message-ID: <20040402123823.GD4304@suse.de>
References: <20040331014351.1ec6f861.akpm@osdl.org> <200403311937.41510@WOLK> <20040402122759.GC4304@suse.de> <200404021432.49440@WOLK>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404021432.49440@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02 2004, Marc-Christian Petersen wrote:
> On Friday 02 April 2004 14:27, Jens Axboe wrote:
> 
> Hi Jens,
> 
> > > is there any reason why I see /sys/block/hda/queue/iosched/ beeing empty?
> > > I thought every I/O scheduler would put in there some tunables or at
> > > least some info's what defaults are used. Or did I miss something
> > > completely and now I am totally wrong?
> 
> > This branch of CFQ doesn't implement the parameters as sysfs modifyable,
> > later versions do.
> 
> Do you have any later versions of cfq? I had cfq-4 with ioprios in my
> tree but that version I have has fatal performance problems compared
> to the cfq-4 in -mm.

Nope, not finalized. I have one that will take a day of work to complete
or so that is pretty much the final design of CFQ I think (before taking
io priorities and making them general).

-- 
Jens Axboe

