Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292884AbSCELbA>; Tue, 5 Mar 2002 06:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292926AbSCELai>; Tue, 5 Mar 2002 06:30:38 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:64265 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S292884AbSCELad>;
	Tue, 5 Mar 2002 06:30:33 -0500
Date: Tue, 5 Mar 2002 12:28:43 +0100
From: Jens Axboe <axboe@suse.de>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.6-pre2 IDE cleanup 16
Message-ID: <20020305112843.GE716@suse.de>
In-Reply-To: <3C84A34E.6060708@evision-ventures.com> <Pine.LNX.4.44.0203051307080.12437-100000@netfinity.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0203051307080.12437-100000@netfinity.realnet.co.sz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05 2002, Zwane Mwaikambo wrote:
> On Tue, 5 Mar 2002, Martin Dalecki wrote:
> 
> > - Disable configuration of the task file stuff. It is going to go away
> >    and will be replaced by a truly abstract interface based on
> >    functionality and *not* direct mess-up of hardware.
> 
> Could you elaborate just a tad on that.

While the taskfile interface is very down-to-basics and a bit extreme
in one end, it's also very useful for eg vendors doing testing and
certification. So in that respect it's pretty powerful, I hope Martin
isn't just planning a stripped down interface akin to what we have in
2.4 and earlier.

-- 
Jens Axboe

