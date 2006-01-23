Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751435AbWAWIhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbWAWIhh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 03:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWAWIhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 03:37:37 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:53839 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751418AbWAWIhg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 03:37:36 -0500
Date: Mon, 23 Jan 2006 09:39:39 +0100
From: Jens Axboe <axboe@suse.de>
To: Chase Venters <chase.venters@clientec.com>
Cc: Andrew Morton <akpm@osdl.org>, Anton Titov <a.titov@host.bg>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: OOM Killer killing whole system
Message-ID: <20060123083939.GB12773@suse.de>
References: <1137337516.11767.50.camel@localhost> <1137793685.11771.58.camel@localhost> <20060120145006.0a773262.akpm@osdl.org> <200601201819.58366.chase.venters@clientec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601201819.58366.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20 2006, Chase Venters wrote:
> On Friday 20 January 2006 16:49, Andrew Morton wrote:
> > This is 2.6.15 and we have a deadly bug in scsi.
> >
> > Next time you reboot 2.6.15 on that machine can you please send the output
> > of `dmesg -s 1000000'?  You might have to set CONFIG_LOG_BUF_SHIFT=17 to
> > prevent it from being truncated.
> 
> Here's mine (attached). Curious - the -s... were you expecting the
> ring buffer to exceed 16384? I don't think my (boot time) buffer does.

Just a note - you seem to have the raid1 in common with the rest of the
reporters so far.

-- 
Jens Axboe

