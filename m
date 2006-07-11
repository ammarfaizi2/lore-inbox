Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWGKTPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWGKTPx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 15:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbWGKTPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 15:15:53 -0400
Received: from mail.suse.de ([195.135.220.2]:25007 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932097AbWGKTPw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 15:15:52 -0400
Date: Tue, 11 Jul 2006 21:15:48 +0200
From: Olaf Hering <olh@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jeff Garzik <jeff@garzik.org>, Michael Tokarev <mjt@tls.msk.ru>,
       Roman Zippel <zippel@linux-m68k.org>, torvalds@osdl.org,
       klibc@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [klibc] klibc and what's the next step?
Message-ID: <20060711191548.GA17585@suse.de>
References: <20060711164040.GA16327@suse.de> <44B3DA77.50103@garzik.org> <20060711171624.GA16554@suse.de> <44B3DEA0.3010106@zytor.com> <20060711173030.GA16693@suse.de> <44B3E40E.2090306@zytor.com> <20060711180126.GB16869@suse.de> <44B3E814.3060004@zytor.com> <20060711181055.GC16869@suse.de> <44B3EB28.1050007@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <44B3EB28.1050007@zytor.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Jul 11, H. Peter Anvin wrote:

> Olaf Hering wrote:
> >Now I'm confused.
> >Is the kernel partition code supposed to go at some point?
> >Some people suggested that, but Linus was not convinced.
> 
> It's a proposal, and I personally think it makes sense.  If done, it is 
> obviously very important that it doesn't change the overall operation of 
> the system.

I think you can have that today, parted uses BLKPG to add and remoe
things. No idea what the benefit would be, but thats not relavant for
kinit or no kinit.
