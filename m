Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313089AbSDOS0f>; Mon, 15 Apr 2002 14:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313091AbSDOS0e>; Mon, 15 Apr 2002 14:26:34 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:19470 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S313089AbSDOS0e>;
	Mon, 15 Apr 2002 14:26:34 -0400
Date: Mon, 15 Apr 2002 20:26:39 +0200
From: Jens Axboe <axboe@suse.de>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE TCQ #4
Message-ID: <20020415182639.GY12608@suse.de>
In-Reply-To: <274A9BD5C76@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15 2002, Petr Vandrovec wrote:
> On 15 Apr 02 at 18:44, Jens Axboe wrote:
> 
> > > You can run a IDENTIFY_DEVICE from user space with the task ioctls and
> > > look at word 83 -- bit 1 and 14 must be set for TCQ to be supported. If
> > > you give me the model identifier from the IBM drive, I can tell you if
> > > it has tcq or not...
> > > 
> > > I'll write a small util to detect this tomorrow and send it to you + the
> > > list.
> > 
> > Duh, you can of course just look at /proc/ide/ideX/hdY/identify and
> > parse that. The info above is still valid for that, of course :-)
> 
> If I parsed file correctly (it is 83 decimal word, yes?), WD's
> WDC WD1200JB-00CRA0 supports TCQ too. I'm still deciding which of

Ok

> TCQ #X and IDE #YY patches should be aplied to 2.5.8 to get optimal
> results (and I have to disconnect slaves...).

The latest I posted, and slaves are fine.

-- 
Jens Axboe

