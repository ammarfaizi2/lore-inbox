Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319661AbSIMOiH>; Fri, 13 Sep 2002 10:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319663AbSIMOiG>; Fri, 13 Sep 2002 10:38:06 -0400
Received: from dsl-213-023-022-092.arcor-ip.net ([213.23.22.92]:60814 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319661AbSIMOiG>;
	Fri, 13 Sep 2002 10:38:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Thunder from the hill <thunder@lightweight.ods.org>
Subject: Re: [RFC] Raceless module interface
Date: Fri, 13 Sep 2002 16:44:56 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Thunder from the hill <thunder@lightweight.ods.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Roman Zippel <zippel@linux-m68k.org>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0209130820410.10048-100000@hawkeye.luckynet.adm>
In-Reply-To: <Pine.LNX.4.44.0209130820410.10048-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17prgo-00089o-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 September 2002 16:33, Thunder from the hill wrote:
> Hi,
> 
> On Fri, 13 Sep 2002, Daniel Phillips wrote:
> > > Because in your example, my_module_start() would not be able to run 
> > > separately
> > 
> > That's obvious.  What hasn't been shown is why that's necessary.
> 
> Yeah, but it was also obvious that my_module_init() can fail this way. 
> Look, first we watch the module initialization, that is, we run the 
> critical stuff like resource allocation, data structure allocation, etc. 
> If we fail here, we can't load the module, because it would be unoperative 
> if we proceed. (Because the data simply isn't there.)
> 
> And possibly Rusty wanted to avoid a certain race, which is unrelated to
> school and kids. Once we've initialized, the module can be used, earlier
> is balderdash.

On the face of it, your post is content-free.  To redeem yourself,
please identify the race Rusty avoided and show how I did not avoid
the same race.

-- 
Daniel
