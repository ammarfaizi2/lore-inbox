Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbWFZHT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbWFZHT4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 03:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWFZHT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 03:19:56 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:8041 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932301AbWFZHT4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 03:19:56 -0400
Date: Mon, 26 Jun 2006 09:21:25 +0200
From: Jens Axboe <axboe@suse.de>
To: gary sheppard <rhyotte@gmail.com>
Cc: =?iso-8859-1?Q?Andr=E9?= Goddard Rosa <andre.goddard@gmail.com>,
       ck@vds.kolivas.org, linux-kernel@vger.kernel.org
Subject: Re: [ck] Re: [PATCH] fcache: a remapping boot cache
Message-ID: <20060626072125.GG3966@suse.de>
References: <20060515091806.GA4110@suse.de> <20060515101019.GA4068@suse.de> <20060516074628.GA16317@suse.de> <4d8e3fd30605301438k457f6242x1df64df9bab7f8f1@mail.gmail.com> <20060531061234.GC29535@suse.de> <1e1a7e1b0606232044x11136be5p332716b757ecd537@mail.gmail.com> <20060624110959.GQ4083@suse.de> <b8bf37780606240503s4713283eo2b8aa43513751da9@mail.gmail.com> <20060626064313.GB3966@suse.de> <fe15b94a0606260015i440c995vda3327cc3c4c8210@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe15b94a0606260015i440c995vda3327cc3c4c8210@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26 2006, gary sheppard wrote:
> The thing is there are a lot of Desktop users out there who for various
> reasons will shut down their systems either every night, or every few days.
> Where I live now is notorious for brown outs and black outs. Now in a server
> room you *WILL* have battery backup and of course will simply laugh at such
> an event. In the home very few people I know who have computers have a
> battery backup system. For those types of people anything to help boot time
> is nice to have. It may be totally bogus to equate boot time with system
> performance but many folks do in fact equate boot time/ system
> responsiveness to performance. I very much believe that your work with
> Fcache is and will be very much appreciated. Another project

Yes, I realize that and I look forward to posting some numbers on the
newer fcache later today. It should be even faster than before. I just
stated my personal usage pattern, I know it might not be the average.

> http://www.initng.org/   is actively working on reducing boot time. I
> actually downloaded their live CD and have to admit it is pretty good!

Fixing init scripts is of course a priority, but it needs to happen with
improve disk layout as well to get the huge speed increase.

There are also things like kernel device detection. SATA is pretty
quick, but the old IDE is dog slow and you easily waste many seconds
there.

-- 
Jens Axboe

