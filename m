Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315259AbSGUXE3>; Sun, 21 Jul 2002 19:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315265AbSGUXE3>; Sun, 21 Jul 2002 19:04:29 -0400
Received: from dsl-213-023-043-192.arcor-ip.net ([213.23.43.192]:28319 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315259AbSGUXE2>;
	Sun, 21 Jul 2002 19:04:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Mark Spencer <markster@linux-support.net>
Subject: Re: Zaptel Pseudo TDM Bus
Date: Mon, 22 Jul 2002 01:09:03 +0200
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0207211551350.25617-100000@hoochie.linux-support.net>
In-Reply-To: <Pine.LNX.4.33.0207211551350.25617-100000@hoochie.linux-support.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17WPp2-0007iI-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 July 2002 23:00, Mark Spencer wrote:
> > See the other poster's comment about providing a clear separation of
> > kernel and userspace components in your source tree.  It just makes it 
> > easier to get oriented.
> 
> *nods* Actually the kernel and user packages are in different projects
> (zaptel is the kernel level interface, with only a couple of user tools
> for its configuration, while zapata is the library interface).  Perhaps
> some people might want to contact me off-list to suggest cleaner ways of
> organizing the code.

I'll stay on-list just in case, it's better to have feedback.

I think you want to take everything that belongs in the kernel and put it 
under a subdirectory, say, "kernel", and lay it out exactly as it would be if
your patch were accepted into linus's tree.  That is, the headers go in 
kernel/include/linux, the modules in kernel/drivers/asterisk/whichever.
It nests your tree more deeply, but it's going to end up like that anyway
(you hope) so it might as well be that way now.

-- 
Daniel
