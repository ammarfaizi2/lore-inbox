Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261525AbTCGLBW>; Fri, 7 Mar 2003 06:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261515AbTCGLA4>; Fri, 7 Mar 2003 06:00:56 -0500
Received: from [195.39.17.254] ([195.39.17.254]:5892 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261508AbTCGLA0>;
	Fri, 7 Mar 2003 06:00:26 -0500
Date: Wed, 5 Mar 2003 19:02:22 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: Nigel Cunningham <ncunningham@clear.net.nz>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SWSUSP Discontiguous pagedir patch
Message-ID: <20030305180222.GA2781@zaurus.ucw.cz>
References: <1046487717.4616.22.camel@laptop-linux.cunninghams> <Pine.LNX.4.33.0303021731510.1120-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0303021731510.1120-100000@localhost.localdomain>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Thus, I still think we can go with the patch I submitted before. I've
> > rediffed it against 2.5.63 (less the bits already applied).
> 
> I've spent the last week reading, reviewing, and rewriting major portions 
> of swsusp. I've actually been reasonably impressed, once I was able to get 
> the code into a much more readable state. 
> 
> All in all, I think the idea of saving state to swap is dangerous for 
> various reasons. However, I like some of the other concepts of the code, 

Can you elaborate? I believe writing
to swap is good for user; and it works.

> and will use them in developing a more palatable mechanism of doing STDs 

What is STD?


> http://ldm.bkbits.net:8080/linux-2.5-power
>

Can you post cumulative diff of work-in-progress?
I am not permitted to use bk. Also please
make sure that you post the diff before
you merge it (and please Cc me).
				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

