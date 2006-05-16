Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbWEPWTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWEPWTS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 18:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWEPWTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 18:19:18 -0400
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:1442 "EHLO
	clueserver.org") by vger.kernel.org with ESMTP id S932211AbWEPWTR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 18:19:17 -0400
Date: Tue, 16 May 2006 15:19:16 -0700 (PDT)
From: alan <alan@clueserver.org>
X-X-Sender: alan@blackbox.fnordora.org
To: linux cbon <linuxcbon@yahoo.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: replacing X Window System !
In-Reply-To: <20060516214148.14432.qmail@web26611.mail.ukl.yahoo.com>
Message-ID: <Pine.LNX.4.64.0605161513590.24814@blackbox.fnordora.org>
References: <20060516214148.14432.qmail@web26611.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2006, linux cbon wrote:

> hi,
>
> I know it may not be the best place, sorry for that.
>
> X Window System is old, not optimized, slow, not
> secure (uses root much), accesses the video hardware
> directly (thats the kernel's job !), it cannot do VNC,
> etc.
>
> The question is : what are your ideas to make a system
> remplacing X Window System ?
>
> I think that linux kernel should contain a very basic
> and universal Window System module (which could also
> work on Unixes and BSDs) to replace X, X.org etc.
>
> What do you think about this ?

This is a topic that comes up every year or so.  Every year the result is 
the same.  It is not going to happen.

First of all, your assumptions are incorrect.  Modern versions of X are 
not old, unoptimised, will do remote sessions, etc.

There are a couple of very hard problems here.

First you have to come up with a design that is better than X.  That is 
pretty hard.  Next you have to convince all the programmers to port their 
code over to use your new spiffy API.  That is even harder.

Until you have a working model, or at least a design, you can blue-sky all 
you want.  It won't get anywhere and just waste other people's electrons.

-- 
"Waiter! This lambchop tastes like an old sock!" - Sheri Lewis
