Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283711AbRK3T7c>; Fri, 30 Nov 2001 14:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283773AbRK3T7P>; Fri, 30 Nov 2001 14:59:15 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:22028 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S283766AbRK3T6n>;
	Fri, 30 Nov 2001 14:58:43 -0500
Date: Fri, 30 Nov 2001 20:58:20 +0100
From: Jens Axboe <axboe@suse.de>
To: Gertjan van Wingerde <gwingerde@home.nl>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Compile fixes for 2.5.1-pre4
Message-ID: <20011130205820.D25987@suse.de>
In-Reply-To: <3C07D770.3010807@home.nl> <20011130201231.G22698@suse.de> <3C07DD68.30707@home.nl> <20011130203155.A25987@suse.de> <3C07E4B7.1060109@home.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C07E4B7.1060109@home.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30 2001, Gertjan van Wingerde wrote:
> >Note that there is no straight conversion between before having a 1-1
> >mapping between a buffer_head and a data element and now potentially a
> >1-n mapping with bio. If you are just remapping, no problem.
> >
> >So I'd rather not take these patches unless you've looked into why it
> >_does_ (or maybe does not) work. I'll make note to review them soon, ok?
> >
> >
> 
> Okay. BTW I'm currently setting up my machine to run some tests on this 
> code (I'll have to find some current version of raidtools first :-(.

Excellent, thanks for doing this. We definitely need more people
starting to pick up the pieces.

-- 
Jens Axboe
