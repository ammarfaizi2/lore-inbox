Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292934AbSCEMFp>; Tue, 5 Mar 2002 07:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292947AbSCEMFf>; Tue, 5 Mar 2002 07:05:35 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:47372 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S292934AbSCEMFV>;
	Tue, 5 Mar 2002 07:05:21 -0500
Date: Tue, 5 Mar 2002 13:04:26 +0100
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.6-pre2 IDE cleanup 16
Message-ID: <20020305120426.GC14996@suse.de>
In-Reply-To: <3C84A34E.6060708@evision-ventures.com> <Pine.LNX.4.44.0203051307080.12437-100000@netfinity.realnet.co.sz> <20020305112843.GE716@suse.de> <3C84B1FB.2050003@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C84B1FB.2050003@evision-ventures.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05 2002, Martin Dalecki wrote:
> Jens Axboe wrote:
> >On Tue, Mar 05 2002, Zwane Mwaikambo wrote:
> >
> >>On Tue, 5 Mar 2002, Martin Dalecki wrote:
> >>
> >>
> >>>- Disable configuration of the task file stuff. It is going to go away
> >>>  and will be replaced by a truly abstract interface based on
> >>>  functionality and *not* direct mess-up of hardware.
> >>>
> >>Could you elaborate just a tad on that.
> >>
> >
> >While the taskfile interface is very down-to-basics and a bit extreme
> >in one end, it's also very useful for eg vendors doing testing and
> >certification. So in that respect it's pretty powerful, I hope Martin
> >isn't just planning a stripped down interface akin to what we have in
> >2.4 and earlier.
> 
> No quite my plan is:
> 
> 1. Rip it off.
> 2. Reimplement stuff if and only if someone really shows pressure
> for using it.

Someone has, I'll forward you the stuff.

> The "command parsing" excess is certainly going to go.

Agree

-- 
Jens Axboe

