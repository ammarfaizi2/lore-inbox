Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752727AbVHGUuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727AbVHGUuq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 16:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752728AbVHGUuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 16:50:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34743 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752727AbVHGUup (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 16:50:45 -0400
Date: Sun, 7 Aug 2005 13:50:43 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.13-rc6: aic7xxx testers please..
In-Reply-To: <1123447130.12766.35.camel@mindpipe>
Message-ID: <Pine.LNX.4.58.0508071349580.3258@g5.osdl.org>
References: <Pine.LNX.4.58.0508071136020.3258@g5.osdl.org>
 <1123447130.12766.35.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Aug 2005, Lee Revell wrote:
> 
> It looks like CONFIG_4KSTACKS has gone away (IOW 8K stacks are no longer
> an option).  But now I get this ominous warning when I compile
> ndiswrapper:

It's still there, and it (still) depends on DEBUG_KERNEL. Nothing should 
have changed afaik..

		Linus
