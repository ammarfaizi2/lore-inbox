Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbVBRAwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVBRAwy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 19:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVBRAwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 19:52:54 -0500
Received: from fire.osdl.org ([65.172.181.4]:62656 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261281AbVBRAww (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 19:52:52 -0500
Date: Thu, 17 Feb 2005 16:52:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Joshua Kwan <joshk@triplehelix.org>
cc: linux-kernel@vger.kernel.org, hostap@shmoo.com
Subject: Re: 2.6.10: irq 12 nobody cared!
In-Reply-To: <421539FD.10806@triplehelix.org>
Message-ID: <Pine.LNX.4.58.0502171651350.2371@ppc970.osdl.org>
References: <4214450B.6090006@triplehelix.org> <Pine.LNX.4.58.0502171632120.2371@ppc970.osdl.org>
 <421539FD.10806@triplehelix.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 17 Feb 2005, Joshua Kwan wrote:

> > What was the previous kernel you ran on that machine, just out of
> > interest? If it hasn't happened before, it would be interesting to know
> > when it started happening...
> 
> It used to be running 2.4.27, where there was no evidence of such a bug
> occurring. I'd rather not bother with trying to find out what's going on
> if it'll require me to reboot with all sorts prerelease snapshots, since
> this is my web server, mail server, etc...

2.4.x won't even report that condition. So if it's still working in 2.6.x,
then you can probably pretty much assume that the problem was always
there, but 2.4.x just never talked about it.

			Linus
