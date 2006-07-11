Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbWGKRac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbWGKRac (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 13:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWGKRac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 13:30:32 -0400
Received: from mail.suse.de ([195.135.220.2]:5276 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751074AbWGKRab (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 13:30:31 -0400
Date: Tue, 11 Jul 2006 19:30:30 +0200
From: Olaf Hering <olh@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jeff Garzik <jeff@garzik.org>, Michael Tokarev <mjt@tls.msk.ru>,
       Roman Zippel <zippel@linux-m68k.org>, torvalds@osdl.org,
       klibc@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [klibc] klibc and what's the next step?
Message-ID: <20060711173030.GA16693@suse.de>
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <Pine.LNX.4.64.0606271316220.17704@scrub.home> <20060711044834.GA11694@suse.de> <44B37D9D.8000505@tls.msk.ru> <20060711112746.GA14059@suse.de> <44B3D0A0.7030409@zytor.com> <20060711164040.GA16327@suse.de> <44B3DA77.50103@garzik.org> <20060711171624.GA16554@suse.de> <44B3DEA0.3010106@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <44B3DEA0.3010106@zytor.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Jul 11, H. Peter Anvin wrote:

> "Old klibc" still exists and is the same code out of the same source tree.

I meant more the "easy to build" part.

> >>* Makes it easier to move stuff between kernel and userspace.
> >
> >What do you have in mind here?
> >Once prepare_namespace is gone, there is no userspace code left.
> 
> Things that have been bandied about, for example:
> 
> 	- suspend/resume
> 	- partition discovery
> 
> I'm sure there is more.

Do you plan to share source files betweek kernel and kinit? Or how is it
harder for external kinit to handle that?
