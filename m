Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317478AbSF1STq>; Fri, 28 Jun 2002 14:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317480AbSF1STp>; Fri, 28 Jun 2002 14:19:45 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:6353 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317478AbSF1STn>;
	Fri, 28 Jun 2002 14:19:43 -0400
Date: Fri, 28 Jun 2002 20:21:55 +0200
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Status of write barrier support for 2.4?
Message-ID: <20020628202155.D777@suse.de>
References: <20020628200203.A777@suse.de> <Pine.LNX.4.10.10206281108100.2888-100000@master.linux-ide.org> <20020628202053.C777@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020628202053.C777@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28 2002, Jens Axboe wrote:
> On Fri, Jun 28 2002, Andre Hedrick wrote:
> > 
> > Jens,
> > 
> > I just got crapped all over trying to get us "write barrier" opcodes :-/.
> > However I do have the start of a draft to submit soon.  I could not piggy
> > back of FUA by MicroSoft last week.
> 
> Basic FUA bit for WRITE command would be good, as long as it also
> prevents reordering of the writes currently in write cache. I don't
> think mmc makes any such guarentee, although I would have to check to be
> sure.

Oh, and of course options for the tagged commands are needed as well!

-- 
Jens Axboe

