Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751442AbWAWImJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbWAWImJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 03:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbWAWImI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 03:42:08 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:51077 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751438AbWAWImH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 03:42:07 -0500
Subject: Re: OOM Killer killing whole system
From: Arjan van de Ven <arjan@infradead.org>
To: Jens Axboe <axboe@suse.de>
Cc: Chase Venters <chase.venters@clientec.com>, Andrew Morton <akpm@osdl.org>,
       Anton Titov <a.titov@host.bg>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
In-Reply-To: <20060123083939.GB12773@suse.de>
References: <1137337516.11767.50.camel@localhost>
	 <1137793685.11771.58.camel@localhost>
	 <20060120145006.0a773262.akpm@osdl.org>
	 <200601201819.58366.chase.venters@clientec.com>
	 <20060123083939.GB12773@suse.de>
Content-Type: text/plain
Date: Mon, 23 Jan 2006 09:41:58 +0100
Message-Id: <1138005718.2977.22.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-23 at 09:39 +0100, Jens Axboe wrote:
> On Fri, Jan 20 2006, Chase Venters wrote:
> > On Friday 20 January 2006 16:49, Andrew Morton wrote:
> > > This is 2.6.15 and we have a deadly bug in scsi.
> > >
> > > Next time you reboot 2.6.15 on that machine can you please send the output
> > > of `dmesg -s 1000000'?  You might have to set CONFIG_LOG_BUF_SHIFT=17 to
> > > prevent it from being truncated.
> > 
> > Here's mine (attached). Curious - the -s... were you expecting the
> > ring buffer to exceed 16384? I don't think my (boot time) buffer does.
> 
> Just a note - you seem to have the raid1 in common with the rest of the
> reporters so far.

time to get out some of the obvious heavy hitters.. and enable slab
debug and CONFIG_DEBUG_PAGEALLOC just with the chance to catch a random
scribble of sorts

