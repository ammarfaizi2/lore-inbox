Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268553AbTBOIXc>; Sat, 15 Feb 2003 03:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268554AbTBOIXb>; Sat, 15 Feb 2003 03:23:31 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:48558 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S268553AbTBOIXb>;
	Sat, 15 Feb 2003 03:23:31 -0500
Date: Sat, 15 Feb 2003 09:33:15 +0100
From: Jens Axboe <axboe@suse.de>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CFQ scheduler, #2
Message-ID: <20030215083315.GE26738@suse.de>
References: <3DF453C8.18B24E66@digeo.com> <200212092059.06287.tomlins@cam.org> <3DF54BD7.726993D@digeo.com> <200302141638.44843.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302141638.44843.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14 2003, Ed Tomlinson wrote:
> Jens Axboe wrote:
>  
> > The version posted the other day did fair queueing of requests between
> > processes, but it did not help to provide fair request allocation. This
> > version does that too, results are rather remarkable. In addition, the
> > following changes were made:
> 
> The numbers from the second message are nice - especially considering this
> is only the second iteration...
> 
> A question about io priorities.  I wonder if they could not be implemented
> via a per pid cfq_quantum?  If I am not missunderstanding things, a bigger
> value here for a given process should mean that it gets a larger share of 
> the io bandwidth...

That's exactly right, and yes that would be one way of doing it.

-- 
Jens Axboe

