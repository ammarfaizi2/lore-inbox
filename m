Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbVIOGiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbVIOGiL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 02:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbVIOGiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 02:38:11 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19159 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932527AbVIOGiL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 02:38:11 -0400
Date: Thu, 15 Sep 2005 08:37:53 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [linux-pm] swsusp3: push image reading/writing into userspace
Message-ID: <20050915063753.GA2691@elf.ucw.cz>
References: <20050914223206.GA2376@elf.ucw.cz> <1126749596.3987.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126749596.3987.5.camel@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Here's prototype code for swsusp3. It seems to work for me, but don't
> > try it... yet. Code is very ugly at places, sorry, I know and will fix
> > it. This is just proof that it can be done, and that it can be done
> > without excessive ammount of code.
> 
> No comments on the code sorry. Instead I want to ask, could you please
> find a different name? swsusp3 is going to make people think that it's
> Suspend2 redesigned. Since there hasn't been a swsusp2 (so far as I
> know), how about using that name instead? At least then we'll clearly
> differentiate the two implementations and you won't confuse/irritate
> users.

swsusp2 can't be used, it is already "taken" by suspend2 (25000 hits
on google). I was actually hoping that you would release suspend4
(using swsusp3 infrastructure) :-).

I guess I could call it "uswsusp".

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
