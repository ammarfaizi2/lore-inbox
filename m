Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261942AbTCHA1x>; Fri, 7 Mar 2003 19:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261951AbTCHA1x>; Fri, 7 Mar 2003 19:27:53 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:22022 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261942AbTCHA1w>; Fri, 7 Mar 2003 19:27:52 -0500
Date: Sat, 8 Mar 2003 01:38:12 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Russell King <rmk@arm.linux.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>, Greg KH <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
In-Reply-To: <3E692EE4.9020905@zytor.com>
Message-ID: <Pine.LNX.4.44.0303080116500.32518-100000@serv>
References: <Pine.LNX.4.44.0303072121180.5042-100000@serv>
 <Pine.LNX.4.44.0303071459260.1309-100000@home.transmeta.com>
 <20030307233916.Q17492@flint.arm.linux.org.uk> <3E692EE4.9020905@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 7 Mar 2003, H. Peter Anvin wrote:

> Right, of course.  However, the first step (which Greg has accomplished)
> is to get klibc merged into the kernel build.  We already have ipconfig
> and mount-nfs binaries which compile against klibc; now we need to
> integrate them so they can pick up the ip= and nfsroot= options and do
> the right thing in userspace.

But before it's actually merged, I would slowly really like to know the 
reasoning for license. You completely avoid that question and that makes 
me nervous. Why did you choose this license over any GPL variant?
We could as well integrate dietlibc and if anyone has a problem with it, 
he can still choose your klibc.
Why should I contribute to klibc instead of dietlibc?

bye, Roman


