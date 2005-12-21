Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932467AbVLUQaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbVLUQaq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 11:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbVLUQaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 11:30:46 -0500
Received: from main.gmane.org ([80.91.229.2]:30103 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932467AbVLUQap (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 11:30:45 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>
Subject: Re: About 4k kernel stack size....
Date: Wed, 21 Dec 2005 11:25:42 -0500
Message-ID: <dobvlf$ife$1@sea.gmane.org>
References: <20051218231401.6ded8de2@werewolf.auna.net> <43A77205.2040306@rtr.ca> <20051220133729.GC6789@stusta.de> <170fa0d20512200637l169654c9vbe38c9931c23dfb1@mail.gmail.com> <BAYC1-PASMTP01F075F44E45AA32F0DF85AE3E0@CEZ.ICE> <dobr1u$19t$1@sea.gmane.org> <2C2D8A91-7BD7-4181-B054-E82A279AF51D@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ool-18b8606d.dyn.optonline.net
User-Agent: KNode/0.9.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:

> Not true.  This is (IIRC) the _third_ flamewar during which a large
> proportion of the comments were either directly or indirectly one of
> the following: "You are intentionally breaking ndiswrapper", "What's
> wrong with having an 8k option?", and "This makes things more-fragile
> or isn't well tested".

If you have paid any attention to the contents of my article, you would know
why it has become flame war. I didn't discuss any technical issues
regarding 4k-stack proposal, nor requested a debatable summary of what has
been going on this proposal. I didn't have anything new to discuss and nor
is rest of your article. I objected to some people (including you) that are
the reason why valid discussion is turning into one by calling people
names.
 
> Windows drivers like that using more than one thread are basically
> inherently racy under current Linux, and probably would not handle
> preemption at all.  If some mess like that breaks due to any in-
> kernel change, you get to keep all 42 pieces.

Take a look at it to understand before commenting on it. ndiswrapper works
fine with preemption and even SMP with certain drivers. It may not work
with SMP with certain drivers, because I don't have hardware to test and
understand the issues. If you have any concerns about ndiswrapper, raise
them on ndiswrapper's mailing list.

> Great, you will probably make a lot of people happy with that.

Again. I am a developer of ndiswrapper and I am doing what I can so people
have a way of using many wireless cards that don't have open source
projects. Just because you don't agree on "moral issues" and what not about
ndiswrapper doesn't mean you have to force users to give up what they may
consider important. Besides, ndiswrapper is about choice; if someone like
you doesn't want to use ndiswrapper, no one is forcing you to, but there
are plenty of users that are aware of issues with using ndiswrapper that
are comfortable with it. I am not interested in further discussing this,
lest this is perceived as stoking flame war. I will rather focus on
constructive issues and help others (as I believe it, anyway).

Giri


