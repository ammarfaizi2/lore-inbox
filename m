Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWGKSB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWGKSB3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 14:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWGKSB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 14:01:29 -0400
Received: from cantor2.suse.de ([195.135.220.15]:57036 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751159AbWGKSB2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 14:01:28 -0400
Date: Tue, 11 Jul 2006 20:01:26 +0200
From: Olaf Hering <olh@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jeff Garzik <jeff@garzik.org>, Michael Tokarev <mjt@tls.msk.ru>,
       Roman Zippel <zippel@linux-m68k.org>, torvalds@osdl.org,
       klibc@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [klibc] klibc and what's the next step?
Message-ID: <20060711180126.GB16869@suse.de>
References: <20060711044834.GA11694@suse.de> <44B37D9D.8000505@tls.msk.ru> <20060711112746.GA14059@suse.de> <44B3D0A0.7030409@zytor.com> <20060711164040.GA16327@suse.de> <44B3DA77.50103@garzik.org> <20060711171624.GA16554@suse.de> <44B3DEA0.3010106@zytor.com> <20060711173030.GA16693@suse.de> <44B3E40E.2090306@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <44B3E40E.2090306@zytor.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Jul 11, H. Peter Anvin wrote:

> It's a deployment problem, arguably especially for people who 
> cross-compile.  You have two major pieces of code (kernel and klibc) 
> which have to be changed at the same time, with different maintainers 
> and reviewers.

Why is that a problem? You cant rip code from the kernel before the main
kinit has support for that removed feature. Thats obvious.
I dont use suspend, so I dont know how the existing in-kernel code has to
look in kinit.
But for the partition discovery (the ROOT_DEV users) its likely less than
100 lines of code. And after all, root= exists. Probably not a big loss if
that code just disappears.

I dont get your point.
