Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317476AbSF1SSo>; Fri, 28 Jun 2002 14:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317478AbSF1SSn>; Fri, 28 Jun 2002 14:18:43 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:2513 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317476AbSF1SSm>;
	Fri, 28 Jun 2002 14:18:42 -0400
Date: Fri, 28 Jun 2002 20:20:53 +0200
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Status of write barrier support for 2.4?
Message-ID: <20020628202053.C777@suse.de>
References: <20020628200203.A777@suse.de> <Pine.LNX.4.10.10206281108100.2888-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10206281108100.2888-100000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28 2002, Andre Hedrick wrote:
> 
> Jens,
> 
> I just got crapped all over trying to get us "write barrier" opcodes :-/.
> However I do have the start of a draft to submit soon.  I could not piggy
> back of FUA by MicroSoft last week.

Basic FUA bit for WRITE command would be good, as long as it also
prevents reordering of the writes currently in write cache. I don't
think mmc makes any such guarentee, although I would have to check to be
sure.

> So how did the talk go at OLS for the IDE roadmap to destruction go?
> I could not attend, as I was doing other stuff associated with the
> industry.

I don't think there was such a talk?! If so, I didn't attend.

-- 
Jens Axboe

