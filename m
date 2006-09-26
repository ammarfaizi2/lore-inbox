Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbWIZVoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbWIZVoF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 17:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964850AbWIZVoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 17:44:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58253 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964846AbWIZVoA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 17:44:00 -0400
Date: Tue, 26 Sep 2006 14:43:56 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: x86/x86-64 merge for 2.6.19
In-Reply-To: <4d8e3fd30609261425ob262489nec1240f5a0c5050f@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0609261439220.3952@g5.osdl.org>
References: <200609261244.43863.ak@suse.de> <200609262202.28846.ak@suse.de>
  <Pine.LNX.4.64.0609261318240.3952@g5.osdl.org>  <200609262226.09418.ak@suse.de>
  <Pine.LNX.4.64.0609261339050.3952@g5.osdl.org>
 <4d8e3fd30609261425ob262489nec1240f5a0c5050f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 26 Sep 2006, Paolo Ciarrocchi wrote:
>
> out of curiosity, wouldn't be better to sync with Andrew via git?
> Why via plain patches?
> 
> What am I missing?

I think you're just missing that we've become so used to it that it's just 
easier than all the alternatives.

Also, the way we do things with Andrew actually has a few advantages over 
a straight git-to-git merge. In particular, when Andrew sends me his 
current stable quilt queue, every email is also Cc'd to the people who 
sent it to him originally or were otherwise involved.

So the very act of transferring the patches from one tree to another 
sometimes produces an extra acknowledgement cycle, and we've had patches 
that got NACK'ed at that point because it was an older version of the 
patch etc.

Now, I suspect this is more of an advantage with Andrew's tree than with 
most other trees (most other trees tend to have a much stricter focus), 
and perhaps equally importantly, it also wouldn't really work very well if 
_everybody_ did it, so I personally believe this is one of those 
situations where what's good for _one_ case may not actually be wonderful 
for _all_ cases.

I think it's worked out pretty well, no?

			Linus
