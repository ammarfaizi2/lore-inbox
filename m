Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261289AbRGEVEE>; Thu, 5 Jul 2001 17:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263257AbRGEVDy>; Thu, 5 Jul 2001 17:03:54 -0400
Received: from vitelus.com ([64.81.36.147]:11792 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S261289AbRGEVDf>;
	Thu, 5 Jul 2001 17:03:35 -0400
Date: Thu, 5 Jul 2001 14:03:30 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: Guest section DW <dwguest@win.tue.nl>
Cc: Stephen C Burns <sburns@farpointer.net>, linux-kernel@vger.kernel.org,
        83710@bugs.debian.org
Subject: [OT] Re: LILO calling modprobe?
Message-ID: <20010705140330.C22723@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010705224245.A1789@win.tue.nl>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     cache_add("/dev/hda",0x300);
>     for (i = 1; i <= 8; i++) {
>         sprintf(tmp,"/dev/hda%d",i);
>         cache_add(tmp,0x300+i);
> 
> Before doing anything LILO v21 collects the hda, hdb, sda, sdb info.
> There is no problem, certainly no kernel problem.

Sure it isn't a problem, but it's really annoying if it won't need to
touch hda anyway.

Is there a reason that it does this?
