Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263755AbUDBM2F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 07:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264032AbUDBM2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 07:28:05 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:40130 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263755AbUDBM2D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 07:28:03 -0500
Date: Fri, 2 Apr 2004 14:27:59 +0200
From: Jens Axboe <axboe@suse.de>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.5-rc3-mm2
Message-ID: <20040402122759.GC4304@suse.de>
References: <20040331014351.1ec6f861.akpm@osdl.org> <200403311937.41510@WOLK>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403311937.41510@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31 2004, Marc-Christian Petersen wrote:
> On Wednesday 31 March 2004 11:43, Andrew Morton wrote:
> 
> Hi Jens,
> 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5-rc3/2.6
> >.5-rc3-mm2/
> > cfq-4.patch
> >   CFQ io scheduler
> >   CFQ fixes
> 
> is there any reason why I see /sys/block/hda/queue/iosched/ beeing empty? I 
> thought every I/O scheduler would put in there some tunables or at least some 
> info's what defaults are used. Or did I miss something completely and now I 
> am totally wrong?

This branch of CFQ doesn't implement the parameters as sysfs modifyable,
later versions do.

-- 
Jens Axboe

