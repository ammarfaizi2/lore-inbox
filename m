Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292881AbSCMJ2K>; Wed, 13 Mar 2002 04:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292886AbSCMJ2B>; Wed, 13 Mar 2002 04:28:01 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:16395 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S292881AbSCMJ1o>;
	Wed, 13 Mar 2002 04:27:44 -0500
Date: Wed, 13 Mar 2002 10:27:29 +0100
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, Karsten Weiss <knweiss@gmx.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre3
Message-ID: <20020313092729.GF15877@suse.de>
In-Reply-To: <20020313080946.GC15877@suse.de> <Pine.LNX.4.10.10203130056210.18254-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10203130056210.18254-100000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13 2002, Andre Hedrick wrote:
> 
> Jens,
> 
> Please try again because that is not the real problem.
> All you have shown is that we disagree on the method of page walking
> between BLOCK v/s IOCTL.  This is very minor and I agreed that it is
> reasonable to map the IOCTL buffer in to BH or BIO so this is a net zero
> of negative point.

No this is two issues -- you (ab)using request interface for ioctls is
one thing, I don't care too much about that (although it spreads
confusion and I've already seen at least one copy this code). The other
is that the task handlers are now forced to be separate and the legacy
handlers in ide-disk used.

> How about attempting to describe the differences between the atomic and
> what is violated by who and where.  I will help you later if you get
> stuck.

and bingo, here comes a third issue. Please stay on track.

-- 
Jens Axboe

