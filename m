Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbWGKRYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbWGKRYX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 13:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWGKRYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 13:24:23 -0400
Received: from terminus.zytor.com ([192.83.249.54]:54188 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751018AbWGKRYW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 13:24:22 -0400
Message-ID: <44B3DEA0.3010106@zytor.com>
Date: Tue, 11 Jul 2006 10:23:44 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Olaf Hering <olh@suse.de>
CC: Jeff Garzik <jeff@garzik.org>, Michael Tokarev <mjt@tls.msk.ru>,
       Roman Zippel <zippel@linux-m68k.org>, torvalds@osdl.org,
       klibc@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [klibc] klibc and what's the next step?
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <Pine.LNX.4.64.0606271316220.17704@scrub.home> <20060711044834.GA11694@suse.de> <44B37D9D.8000505@tls.msk.ru> <20060711112746.GA14059@suse.de> <44B3D0A0.7030409@zytor.com> <20060711164040.GA16327@suse.de> <44B3DA77.50103@garzik.org> <20060711171624.GA16554@suse.de>
In-Reply-To: <20060711171624.GA16554@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering wrote:
>  On Tue, Jul 11, Jeff Garzik wrote:
> 
>> Two are IMO fairly plain:
>>
>> * Makes sure you can boot the kernel you just built.
> 
> There is always some sort of prereq when new features get added.
> Documentation/Changes has a long list. Some setup need more updates,
> some need fewer updates. No idea what your experience is.
> Old klibc was trivial to build (modulo that kernel header mess), and I
> expect that kinit handles old kernels.
> 

"Old klibc" still exists and is the same code out of the same source tree.

>> * Makes it easier to move stuff between kernel and userspace.
> 
> What do you have in mind here?
> Once prepare_namespace is gone, there is no userspace code left.

Things that have been bandied about, for example:

	- suspend/resume
	- partition discovery

I'm sure there is more.

	-hpa
