Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261737AbVBOOJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbVBOOJz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 09:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbVBOOJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 09:09:44 -0500
Received: from mx2.perftech.si ([195.246.0.30]:36870 "EHLO mx2.perftech.si")
	by vger.kernel.org with ESMTP id S261727AbVBOOJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 09:09:16 -0500
Date: Tue, 15 Feb 2005 15:09:04 +0100
From: "xerces8" <xerces8@butn.net>
To: "Helge Hafting" <helge.hafting@aitel.hist.no>,
       linux-kernel@vger.kernel.org
Subject: Re: Dummy vt for XFree86 ?
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <WorldClient-F200502151509.AA09040206@butn.net>
X-Mailer: WorldClient 8.0.0f
In-Reply-To: <4211FD5A.9020705@aitel.hist.no>
References: <WorldClient-F200502151033.AA33440074@butn.net> <4211FD5A.9020705@aitel.hist.no>
X-Authenticated-Sender: xerces8@butn.net
X-Spam-Processed: butn.net, Tue, 15 Feb 2005 15:09:06 +0100
	(not processed: message from valid local sender)
X-Return-Path: xerces8@butn.net
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: butn.net, Tue, 15 Feb 2005 15:09:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helge Hafting <helge.hafting@aitel.hist.no>

> The keyboard is very much the issue - your typing either goes into

No, it isn't. I have the keyboard under control. Forget that keyboards
even exist ;-) Trust me.

I know the ruby patch, but I'm trying to make this work with an unpatched
kernel. And the VT switching is the only remaining problem.

At the end I will run 2 X servers ( yes, I am doing a multi-head (or is
it multi-seat ?) system).
Currently when I start the second one, it will perform a VT switch and thereby
"turn off" the first one (it is still running, just not visible).

What if I recompile the kernel with no VT support ?
(that is my next try anyway)

> the VT on the primary card - or into the X session.  There is no other way
> the computer can know what you mean.  I guess you're going to
> run an X session that won't use kbd input at all, given the question you 
> ask?
> 
> The stock 2.6.x can't do it, but take a look at the ruby patch.
> Ruby is really meant for hooking up several keybaords, so you can have one
> keboard for the VT's on your first card and another kbd for the X session.
> This lets several users work at the same time, using only one pc.
> 
> If you don't need the scondary keyboard - don't plug one in.  Ruby can still
> give you a dummy VT where no input or output happens, and X can use that VT.
> 
> Boot the ruby-patched 2.6.x kernel with the "dumbcon=1" parameter to get one
> dummy console, and let X use VT17 which will be that dummy.
> 
> Helge Hafting


