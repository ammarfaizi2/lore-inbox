Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132871AbRDPHU4>; Mon, 16 Apr 2001 03:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132872AbRDPHUr>; Mon, 16 Apr 2001 03:20:47 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:16401 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S132871AbRDPHUm>; Mon, 16 Apr 2001 03:20:42 -0400
Date: Mon, 16 Apr 2001 09:03:20 +0200
From: Pavel Machek <pavel@suse.cz>
To: David Balazic <david.balazic@uni-mb.si>
Cc: pavel@suse.cz,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Let init know user wants to shutdown
Message-ID: <20010416090320.A29717@atrey.karlin.mff.cuni.cz>
In-Reply-To: <3AD5E518.3641B73A@uni-mb.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3AD5E518.3641B73A@uni-mb.si>; from david.balazic@uni-mb.si on Thu, Apr 12, 2001 at 07:25:44PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

> > Init should get to know that user pressed power button (so it can do 
> > shutdown and poweroff). Plus, it is nice to let user know that we can 
> > read such event. [I hunted bug for few hours, thinking that kernel 
> > does not get the event at all]. 
> > 
> > Here's patch to do that. Please apply, 
> >                                                                 Pavel 
> 
> Isn't it better to just send the event to userspace , where
> is it caught by apmd ( or whatever has replaced it ).
> Then it can decide what to do about it, instead of dictating
> a shutdown from kernel ( policy alert ;-) )


I'm not dictating policy: init is free to do anything it is configured
to, including /sbin/apmd --button_came or echo "Don't you dare to
plpress that button again".

> 
> 

-- 
The best software in life is free (not shareware)!		Pavel
GCM d? s-: !g p?:+ au- a--@ w+ v- C++@ UL+++ L++ N++ E++ W--- M- Y- R+
