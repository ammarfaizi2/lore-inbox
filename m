Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292980AbSCDXNP>; Mon, 4 Mar 2002 18:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292982AbSCDXNA>; Mon, 4 Mar 2002 18:13:00 -0500
Received: from smtp4.vol.cz ([195.250.128.43]:60433 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S292984AbSCDXMk>;
	Mon, 4 Mar 2002 18:12:40 -0500
Date: Mon, 4 Mar 2002 19:35:58 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Shaun Jackman <sjackman@shaw.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp list
Message-ID: <20020304183558.GA4117@elf.ucw.cz>
In-Reply-To: <E16gLkD-0000KR-00@quince.jackman> <20020228094035.GB4760@atrey.karlin.mff.cuni.cz> <E16gwHa-0000B7-00@quince.jackman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16gwHa-0000B7-00@quince.jackman>
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > You have to have just one swap partition. Disable one of them.
> Ok, I did that. Now I'm getting an error there's not enough swap space 
> (logical enough I think).
> 
> /critical section: Counting pages to copy[nosave] (pages needed
> :18062+152=18574 free 14689)
> Couldn't get enough free pages, on 3885 pages short.
> Kernel panic: Not enough free pages
> 
> If both swap partitions is disallowed, and one swap partition isn't enough 
> space, is there anything I can do now to make this work? I'd really
> like to 

This is not enough RAM, there's enough swap. You may try quitting some
applications.

> get suspend working.
> I know at one point 128MB was the limit on a swap partition. Is this limit 
> gone now?

Yep.

> How technically difficult is it to make swsusp work with multiple swap 
> partitions?

Should not be that hard. But you'd have to pass both partitions on
command line, etc.
								Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
