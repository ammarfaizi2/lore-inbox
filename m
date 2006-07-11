Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWGKSRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWGKSRe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 14:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932068AbWGKSRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 14:17:34 -0400
Received: from terminus.zytor.com ([192.83.249.54]:26316 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932067AbWGKSRd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 14:17:33 -0400
Message-ID: <44B3EB28.1050007@zytor.com>
Date: Tue, 11 Jul 2006 11:17:12 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Olaf Hering <olh@suse.de>
CC: Jeff Garzik <jeff@garzik.org>, Michael Tokarev <mjt@tls.msk.ru>,
       Roman Zippel <zippel@linux-m68k.org>, torvalds@osdl.org,
       klibc@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [klibc] klibc and what's the next step?
References: <20060711112746.GA14059@suse.de> <44B3D0A0.7030409@zytor.com> <20060711164040.GA16327@suse.de> <44B3DA77.50103@garzik.org> <20060711171624.GA16554@suse.de> <44B3DEA0.3010106@zytor.com> <20060711173030.GA16693@suse.de> <44B3E40E.2090306@zytor.com> <20060711180126.GB16869@suse.de> <44B3E814.3060004@zytor.com> <20060711181055.GC16869@suse.de>
In-Reply-To: <20060711181055.GC16869@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering wrote:
> Now I'm confused.
> Is the kernel partition code supposed to go at some point?
> Some people suggested that, but Linus was not convinced.

It's a proposal, and I personally think it makes sense.  If done, it is 
obviously very important that it doesn't change the overall operation of 
the system.

> If you mean just 'interpreting the partition table', thats not hard
> either. I just poked at such code in yaboot a few weeks ago.

It's not hard; any of the partition table stuff, but we have quite a 
proliferation of them.  It'd be even easier in userspace.

	-hpa
